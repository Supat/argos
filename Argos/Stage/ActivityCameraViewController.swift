//
//  ActivityCameraViewController.swift
//  Argos
//
//  Created by Supat Saetia on 20/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import AVFoundation
import UIKit
import Vision

protocol ActivityCameraViewDelegate: AnyObject {
    func didRecognizeActivity(_ label: String, withConfidence confidence:Double);
}

class ActivityCameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    weak var outputDelegate: ActivityCameraViewDelegate?;
    
    var captureSession: AVCaptureSession!;
    var previewLayer: AVCaptureVideoPreviewLayer!;
    
    private let videoDataOutput = AVCaptureVideoDataOutput();
    
    private let humanBodyPoseRequest = VNDetectHumanBodyPoseRequest();
    
    private var posesWindow: [VNRecognizedPointsObservation?] = [];
    
    private let bodyPoseDetectionMinConfidence: VNConfidence = 0.6;
    
    private let predictor = TestActionClassifier();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        captureSession = AVCaptureSession();
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return };
        let videoInput: AVCaptureDeviceInput;
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice);
        } catch { return }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput);
        }
        
        self.videoDataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(value: kCVPixelFormatType_32BGRA)] as [String : Any];
        
        self.videoDataOutput.alwaysDiscardsLateVideoFrames = true;
        self.videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera_frame_processing_queue"));
        self.captureSession.addOutput(self.videoDataOutput);
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
        previewLayer.frame = self.view.frame;
        previewLayer.videoGravity = .resizeAspectFill;
        view.layer.addSublayer(previewLayer);
        
        posesWindow.reserveCapacity(120);

        captureSession.startRunning();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera_frame_processing_queue"))
        
        if captureSession?.isRunning == false {
            captureSession.startRunning()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.previewLayer.frame = self.view.layer.bounds

        let orientation: UIDeviceOrientation = UIDevice.current.orientation;

        switch (orientation) {
        case .portrait:
            previewLayer.connection?.videoOrientation = .portrait;
        case .landscapeRight:
            previewLayer.connection?.videoOrientation = .landscapeLeft;
        case .landscapeLeft:
            previewLayer.connection?.videoOrientation = .landscapeRight;
        default:
            previewLayer.connection?.videoOrientation = .portrait;
        }
        
        previewLayer.connection?.automaticallyAdjustsVideoMirroring = false
        previewLayer.connection?.isVideoMirrored = true
        
        previewLayer.videoGravity = .resizeAspectFill;

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if captureSession?.isRunning == true {
            captureSession.stopRunning()
        }
    }
    
    // AVCaptureVideoDataOutputSampleBufferDelegate protocol implementation
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        let visionHandler = VNImageRequestHandler(cmSampleBuffer: sampleBuffer, orientation: .up, options: [:]);
        
        do {
            try visionHandler.perform([humanBodyPoseRequest])
            if let observations = humanBodyPoseRequest.results {
                if (observations.count > 0) {
                    //print(observations[0].confidence);
                    //let poseArray = try? observations[0].keypointsMultiArray();
                    //print(poseArray?.count);
                    posesWindow.append(observations[0]);
                    //print("Before \(posesWindow.count)");
                    if (posesWindow.count >= 60) {
                        //print("Ready for Prediction");
                        let poseMultiArrays: [MLMultiArray] = try posesWindow.map { person in
                            guard let person = person else {
                                let zeroArray = try MLMultiArray(shape: [1, 3, 18], dataType: .double);
                                return zeroArray;
                            }
                            return try person.keypointsMultiArray()
                        }
                        
                        let modelInput = MLMultiArray(concatenating: poseMultiArrays, axis: 0, dataType: .float);
                        
                        let predictions = try predictor.prediction(poses: modelInput);
                        
                        posesWindow.removeFirst(60);
                        
                        //print(predictions.label);
                        //print(predictions.labelProbabilities[predictions.label]!);
                        
                        self.outputDelegate?.didRecognizeActivity(predictions.label, withConfidence: predictions.labelProbabilities[predictions.label]!);
                        //print("After \(posesWindow.count)");
                    }
                } else {
                    //print("No human detected");
                }
            }
        } catch {
            
        }
    }
}
