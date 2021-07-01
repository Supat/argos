//
//  StartActionView.swift
//  Argos
//
//  Created by Supat Saetia on 7/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI

struct StartActionView: View {
    
    @ObservedObject var viewRouter: ViewRouter;
    
    let videoURL: URL? = Bundle.main.url(forResource: "sample_video_1", withExtension: "mp4");
    
    var body: some View {
        VStack {
            Text("Action Type at Difficulty Level")
                .font(.headline);
            
            Spacer()
                .frame(height: 50);
            
            Text("Detail instruction for this session appears here");
            
            Spacer()
                .frame(height: 50);
            
            Text("Are you ready to start?");
            Button(action: {
                print("Start button is pressed");
                self.viewRouter.videoURL = videoURL;
                self.viewRouter.currentPage = "stagePage";
            }) {
                Text("Start");
            }
        }
    }
}

struct StartActionView_Previews: PreviewProvider {
    static var previews: some View {
        StartActionView(viewRouter: ViewRouter())
    }
}
