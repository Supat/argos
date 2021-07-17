//
//  VisionActivityTrackView.swift
//  Argos
//
//  Created by Supat Saetia on 20/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI


struct VisionActivityTrackView: View {
    
    @State private var label = "Not Available"
    @State private var confidence = 0.0
    
    @Binding var performanceScore: Int
    
    let targetLabel: String = "Pose"
    let targetConfidence: Double = 0.8
    
    var body: some View {
        //Text("Vision Activity Track");
        ZStack {
            ActivityCameraRepresentable(label: $label, confidence: $confidence);
            VStack {
                Spacer()
                    .frame(height: 25)
                HStack {
                    Text(label)
                        .font(.system(.title))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .background(
                            Capsule()
                                .fill(.black)
                                .opacity(0.75)
                        )
                }
                HStack {
                    Text("\(confidence, specifier: "%0.2f")")
                        .onChange(of: self.confidence) { _ in
                            if (self.confidence >= self.targetConfidence) {
                                if (self.label == self.targetLabel) {
                                    self.performanceScore += 1
                                }
                            }
                        }
                        .font(.largeTitle)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .background(
                            Capsule()
                                .fill(.black)
                                .opacity(0.75)
                        )
                    
                }
                    .padding(.top)
                    .background(Color.clear);
                Spacer()
            }
        }
    }
}

struct ActivityCameraRepresentable: UIViewControllerRepresentable {
    
    @Binding var label: String;
    @Binding var confidence: Double;
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self);
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityCameraRepresentable>) -> ActivityCameraViewController {
        let controller = ActivityCameraViewController();
        controller.outputDelegate = context.coordinator;
        return controller;
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    class Coordinator: NSObject, ActivityCameraViewDelegate {
        var parent: ActivityCameraRepresentable;
        
        init(_ activityCameraRepresentable: ActivityCameraRepresentable) {
            self.parent = activityCameraRepresentable;
        }
        
        func didRecognizeActivity(_ label: String, withConfidence confidence: Double) {
            parent.label = label;
            parent.confidence = confidence;
        }
    }
}

//struct VisionActivityTrackView_Previews: PreviewProvider {
//    static var previews: some View {
//        VisionActivityTrackView()
//    }
//}
