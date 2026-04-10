//
//  ContentView.swift
//  Argos
//
//  Created by Supat Saetia on 6/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//
//  Legacy RealityKit playground view. Not part of the live navigation
//  graph; kept here because the file is still wired into the build phase.
//

import RealityKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        ARViewContainer()
            .ignoresSafeArea()
    }
}

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        if let boxAnchor = try? Experience.loadBox() {
            arView.scene.anchors.append(boxAnchor)
        }
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}
}

#if DEBUG
#Preview {
    ContentView()
}
#endif
