//
//  VideoView.swift
//  Argos
//
//  Created by Supat Saetia on 17/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI

struct VideoView: UIViewRepresentable {
    let videoURL: URL
    var previewLength: Double = 15

    func makeUIView(context: Context) -> PlayerView {
        PlayerView(frame: .zero, url: videoURL, previewLength: previewLength)
    }

    func updateUIView(_ uiView: PlayerView, context: Context) {}
}
