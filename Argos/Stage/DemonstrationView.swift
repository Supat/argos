//
//  DemonstrationView.swift
//  Argos
//
//  Created by Supat Saetia on 6/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI

struct DemonstrationView: View {
    
    @State var maxHeight:CGFloat = 640
    let videoURL: URL? = Bundle.main.url(forResource: "sample_video_1", withExtension: "mp4");
    
    var body: some View {
        VStack {
            VideoView(videoURL: videoURL!, previewLength: 60)
                .cornerRadius(15)
                .frame(width: nil, height: maxHeight, alignment: .center)
                .shadow(color: Color.black.opacity(0.7), radius: 30, x: 0, y: 2)
                .padding(.horizontal, 20)
                .padding(.top, 20)

            Spacer()
            
            Image(systemName: "play.circle.fill").resizable()
                .frame(width: 120.0, height: 120.0)
            Text("Demonstration video clip appears here.")
        }
    }
}

struct DemonstrationView_Previews: PreviewProvider {
    static var previews: some View {
        DemonstrationView()
    }
}
