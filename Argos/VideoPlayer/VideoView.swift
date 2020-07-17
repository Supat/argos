//
//  VideoView.swift
//  Argos
//
//  Created by Supat Saetia on 17/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI
import AVFoundation
import AVKit

struct VideoView: UIViewRepresentable {
    
    var videoURL:URL;
    var previewLength:Double?
    
    func makeUIView(context: Context) -> UIView {
        return PlayerView(frame: .zero, url: videoURL, previewLength: previewLength ?? 15)
    }
        
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
