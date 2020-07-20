//
//  ActivityCameraViewController.swift
//  Argos
//
//  Created by Supat Saetia on 20/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import AVFoundation
import UIKit

class ActivityCameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var captureSession: AVCaptureSession!;
    var previewLayer: AVCaptureVideoPreviewLayer!;
    
    private let videoDataOutput = AVCaptureVideoDataOutput();
    
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
        
        previewLayer.videoGravity = .resizeAspectFill;

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if captureSession?.isRunning == true {
            captureSession.stopRunning()
        }
    }
}
