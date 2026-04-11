//
//  ActivityCameraViewController.swift
//  Argos
//
//  Created by Supat Saetia on 20/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import AVFoundation
import CoreML
import UIKit
import Vision

protocol ActivityCameraViewDelegate: AnyObject {
    func didRecognizeActivity(_ label: String, withConfidence confidence: Double)
}

/// Reusable base for all action-classifier camera screens.
///
/// Subclasses should override `predictionWindowSize` and
/// `prediction(from:)` to plug in their CoreML model. The capture session,
/// preview layer, body-pose request, and rolling pose buffer are shared.
class ActivityCameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    // MARK: - Output

    weak var outputDelegate: ActivityCameraViewDelegate?

    // MARK: - Configurable hooks

    /// Number of pose observations to feed each prediction. Subclasses
    /// override; defaults to a 60-frame window for the legacy
    /// `TestActionClassifier`.
    var predictionWindowSize: Int { 60 }

    /// Run the bundled CoreML model on the assembled pose multi-array and
    /// return the top label / confidence pair.
    func prediction(from poses: MLMultiArray) throws -> (label: String, confidence: Double)? {
        let predictor = try TestActionClassifier(configuration: MLModelConfiguration())
        let result = try predictor.prediction(poses: poses)
        return (result.label, result.labelProbabilities[result.label] ?? 0)
    }

    // MARK: - Capture pipeline

    private var captureSession: AVCaptureSession?
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private let videoDataOutput = AVCaptureVideoDataOutput()
    private let processingQueue = DispatchQueue(label: "argos.camera.frame_processing")
    private let humanBodyPoseRequest = VNDetectHumanBodyPoseRequest()
    private var posesWindow: [VNHumanBodyPoseObservation?] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let session = AVCaptureSession()

        guard
            let device = AVCaptureDevice.default(for: .video),
            let input = try? AVCaptureDeviceInput(device: device),
            session.canAddInput(input)
        else {
            return
        }
        session.addInput(input)

        videoDataOutput.videoSettings = [
            kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA
        ]
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        videoDataOutput.setSampleBufferDelegate(self, queue: processingQueue)
        session.addOutput(videoDataOutput)

        let preview = AVCaptureVideoPreviewLayer(session: session)
        preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(preview)

        captureSession = session
        previewLayer = preview

        posesWindow.reserveCapacity(max(120, predictionWindowSize * 2))

        Task.detached { [weak session] in
            session?.startRunning()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let session = captureSession, !session.isRunning else { return }
        Task.detached { [weak session] in
            session?.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let session = captureSession, session.isRunning else { return }
        Task.detached { [weak session] in
            session?.stopRunning()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        guard let preview = previewLayer else { return }
        preview.frame = view.layer.bounds
        preview.videoGravity = .resizeAspectFill

        if let connection = preview.connection {
            let angle = videoRotationAngle(for: UIDevice.current.orientation)
            if connection.isVideoRotationAngleSupported(angle) {
                connection.videoRotationAngle = angle
            }
            connection.automaticallyAdjustsVideoMirroring = false
            connection.isVideoMirrored = true
        }
    }

    /// Maps a `UIDeviceOrientation` to the clockwise rotation, in degrees,
    /// that an `AVCaptureConnection` needs in order to display the camera
    /// feed upright. Replaces the deprecated `videoOrientation` API
    /// (removed in iOS 17).
    private func videoRotationAngle(for deviceOrientation: UIDeviceOrientation) -> CGFloat {
        switch deviceOrientation {
        case .portrait:        return 90
        case .landscapeRight:  return 180
        case .landscapeLeft:   return 0
        default:               return 90
        }
    }

    // MARK: - Sample buffer delegate

    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        let handler = VNImageRequestHandler(cmSampleBuffer: sampleBuffer, orientation: .up, options: [:])

        do {
            try handler.perform([humanBodyPoseRequest])
            guard let observation = humanBodyPoseRequest.results?.first else { return }

            posesWindow.append(observation)

            guard posesWindow.count >= predictionWindowSize else { return }
            try runPrediction()
        } catch {
            // Silently ignore — Vision will retry on the next frame.
        }
    }

    private func runPrediction() throws {
        let window = Array(posesWindow.prefix(predictionWindowSize))
        posesWindow.removeFirst(predictionWindowSize)

        let arrays: [MLMultiArray] = try window.map { observation in
            if let observation {
                return try observation.keypointsMultiArray()
            }
            return try MLMultiArray(shape: [1, 3, 18], dataType: .double)
        }

        let modelInput = MLMultiArray(concatenating: arrays, axis: 0, dataType: .float)

        guard let result = try prediction(from: modelInput) else { return }

        DispatchQueue.main.async { [weak self] in
            self?.outputDelegate?.didRecognizeActivity(result.label, withConfidence: result.confidence)
        }
    }
}
