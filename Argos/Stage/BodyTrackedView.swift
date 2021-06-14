//
//  BodyTrackedView.swift
//  Argos
//
//  Created by Supat Saetia on 6/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI
import RealityKit
import ARKit
import Combine

struct BodyTrackedView: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottomTrailing) {
                Text("Score: ")
                BodyTrackedViewContainer().edgesIgnoringSafeArea(.all);
                Text("Addition information appears here")
                    .padding(.trailing)
            }
            Text("Score: ")
                .padding(.trailing)
        }
    }
}

let arSessionDelegate = SessionDelegate();

struct BodyTrackedViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero);
        
        arSessionDelegate.set(arView: arView);
        arView.session.delegate = arSessionDelegate;
        
        guard ARBodyTrackingConfiguration.isSupported else {
            fatalError("This feature is only supported on devices with an A12 chip");
        }
        
        let configuration = ARBodyTrackingConfiguration();
        arView.session.run(configuration);
        
        return arView;
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
}

final class SessionDelegate: NSObject, ARSessionDelegate {
    var arView: ARView!;
    var character: BodyTrackedEntity?;
    let characterOffset: SIMD3<Float> = [0, 0, 0];
    var characterAnchor: AnchorEntity?;
    
    func set(arView: ARView) {
        self.arView = arView;
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        if characterAnchor != nil {
            return;
        }
        
        guard anchors[0] is ARBodyAnchor else {
            return;
        }
        
        characterAnchor = AnchorEntity();
        
        var cancellable: AnyCancellable? = nil;
        cancellable = Entity.loadBodyTrackedAsync(named: "character/robot").sink(receiveCompletion: {completion in
            if case let .failure(error) = completion {
                print("Error: Unable to load model: \(error.localizedDescription)");
            }
            cancellable?.cancel();
        }, receiveValue: { (character: Entity) in
            if let character = character as? BodyTrackedEntity {
                character.scale = [1.0, 1.0, 1.0];
                self.character = character;
                cancellable?.cancel();
            } else {
                print("Error: Unable to load model as BodyTrackedEntity");
            }
        })
        
        if let character = character, character.parent == nil {
            characterAnchor?.addChild(character);
        }
        
        arView.scene.addAnchor(characterAnchor!);
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        for anchor in anchors {
            guard let bodyAnchor = anchor as? ARBodyAnchor else { continue };
            
            let bodyPosition = simd_make_float3(bodyAnchor.transform.columns.3);
            if let characterAnchor = characterAnchor {
                characterAnchor.position = bodyPosition + characterOffset;
                characterAnchor.orientation = Transform(matrix: bodyAnchor.transform).rotation;
            }
            
            if let character = character, character.parent == nil {
                characterAnchor?.addChild(character);
            }

        }
    }
}

struct BodyTrackedView_Previews: PreviewProvider {
    static var previews: some View {
        BodyTrackedView()
    }
}
