//
//  StartActionView.swift
//  Argos
//
//  Created by Supat Saetia on 7/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI
import RealityFoundation

struct StartActionView: View {
    
    @ObservedObject var viewRouter: ViewRouter;
    
    let video: Video;
    let category: Category;
    var body: some View {
        ZStack {
            VStack {
                Text(generateTitleText(for: category.name ?? "Unknown", at: video.difficulty))
                    .font(.headline);
                
                Spacer()
                    .frame(height: 50);
                
                Text("\(String(describing: video.explanation))");
                
                Spacer()
                    .frame(height: 50);
                
                Text("Are you ready to start?");
                Button(action: {
                    print(video.name ?? "URL not found.");
                    self.viewRouter.videoURL = Bundle.main.url(forResource: video.name, withExtension: video.ext);
                    self.viewRouter.stageTimeLimit = 60;
                    self.viewRouter.currentPage = "countdownPage";
                }) {
                    Text("Start");
                }
            }
        }
    }
    
    private func generateTitleText(for stance: String, at level: Int16) -> String {
        return stance + " at Difficulty Level: " + String(level);
    }
}

//struct StartActionView_Previews: PreviewProvider {
//    static var previews: some View {
//        StartActionView(viewRouter: ViewRouter())
//    }
//}
