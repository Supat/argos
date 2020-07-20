//
//  VisionActivityTrackView.swift
//  Argos
//
//  Created by Supat Saetia on 20/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI


struct VisionActivityTrackView: View {
    
    var body: some View {
        //Text("Vision Activity Track");
        ActivityCameraRepresentable();
    }
}

struct ActivityCameraRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> ActivityCameraViewController {
        let controller = ActivityCameraViewController();
        return controller;
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    
}

struct VisionActivityTrackView_Previews: PreviewProvider {
    static var previews: some View {
        VisionActivityTrackView()
    }
}
