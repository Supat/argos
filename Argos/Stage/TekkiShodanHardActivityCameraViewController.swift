//
//  TekkiShodanHardActivityCameraViewController.swift
//  Argos
//
//  Created by Supat Saetia on 2021/07/18.
//  Copyright © 2021 Supat Saetia. All rights reserved.
//

import CoreML

final class TekkiShodanHardActivityCameraViewController: ActivityCameraViewController {

    override var predictionWindowSize: Int { 60 }

    override func prediction(from poses: MLMultiArray) throws -> (label: String, confidence: Double)? {
        let predictor = try TekkiShodanHardActionClassifier(configuration: MLModelConfiguration())
        let result = try predictor.prediction(poses: poses)
        return (result.label, result.labelProbabilities[result.label] ?? 0)
    }
}
