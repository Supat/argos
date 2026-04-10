//
//  VisionActivityTrackView.swift
//  Argos
//
//  Created by Supat Saetia on 20/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI

struct VisionActivityTrackView: View {
    let context: StageContext
    @Binding var classification: Classification

    var body: some View {
        ZStack {
            ActivityCameraRepresentable(context: context, classification: $classification)

            VStack {
                Spacer().frame(height: 25)

                Text(classification.label)
                    .font(.title)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(Capsule().fill(.black.opacity(0.75)))

                Text(String(format: "%0.2f", classification.confidence))
                    .font(.largeTitle)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(Capsule().fill(.black.opacity(0.75)))
                    .padding(.top)

                Spacer()
            }
        }
    }
}

private struct ActivityCameraRepresentable: UIViewControllerRepresentable {
    let context: StageContext
    @Binding var classification: Classification

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> ActivityCameraViewController {
        let controller = makeViewController(for: self.context)
        controller.outputDelegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: ActivityCameraViewController, context: Context) {}

    private func makeViewController(for context: StageContext) -> ActivityCameraViewController {
        guard context.stageName == "Tekki-shodan" else {
            return ActivityCameraViewController()
        }

        switch context.difficulty {
        case .beginner: return TekkiShodanEasyActivityCameraViewController()
        case .medium:   return TekkiShodanMediumActivityCameraViewController()
        case .advanced: return TekkiShodanHardActivityCameraViewController()
        }
    }

    final class Coordinator: NSObject, ActivityCameraViewDelegate {
        let parent: ActivityCameraRepresentable

        init(_ parent: ActivityCameraRepresentable) {
            self.parent = parent
        }

        func didRecognizeActivity(_ label: String, withConfidence confidence: Double) {
            DispatchQueue.main.async { [parent] in
                parent.classification = Classification(label: label, confidence: confidence)
            }
        }
    }
}
