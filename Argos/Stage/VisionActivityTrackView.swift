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
    
    @Binding var classifyLabel: String
    @Binding var classifyConfidence: Double
    
    var stageName: String?
    var stageLevel: Int16?
    
    var body: some View {
        //Text("Vision Activity Track");
        ZStack {
            ActivityCameraRepresentable(label: $label, confidence: $confidence, stageName: self.stageName, stageLevel: self.stageLevel);
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
                            self.classifyLabel = self.label
                            self.classifyConfidence = self.confidence
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
    
    var stageName: String?
    var stageLevel: Int16?
    
    init(label: Binding<String>, confidence: Binding<Double>, stageName: String?, stageLevel: Int16?) {
        self._label = label
        self._confidence = confidence
        self.stageName = stageName
        self.stageLevel = stageLevel
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self);
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityCameraRepresentable>) -> UIViewController {
        print("Stage: " + self.stageName!)
        switch self.stageName {
        case "Tekki-shodan":
            switch self.stageLevel {
            case 0:
                print("Easy Tekki-shodan")
                let controller = TekkiShodanEasyActivityCameraViewController();
                controller.outputDelegate = context.coordinator;
                return controller;
            case 1:
                print("Medium Tekki-shodan")
                let controller = TekkiShodanMediumActivityCameraViewController();
                controller.outputDelegate = context.coordinator;
                return controller;
            case 2:
                print("Hard Tekki-shodan")
                let controller = TekkiShodanHardActivityCameraViewController();
                controller.outputDelegate = context.coordinator;
                return controller;

            default:
                print("Default")
                let controller = ActivityCameraViewController();
                controller.outputDelegate = context.coordinator;
                return controller;
            }
        default:
            print("Default")
            let controller = ActivityCameraViewController();
            controller.outputDelegate = context.coordinator;
            return controller;
        }
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
