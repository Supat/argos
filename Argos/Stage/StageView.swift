//
//  StageView.swift
//  Argos
//
//  Created by Supat Saetia on 6/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI

struct StageView: View {
    
    @ObservedObject var viewRouter: ViewRouter;
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .topLeading) {
                HStack {
                    VStack {
                        VisionActivityTrackView();
                    }
                        .frame(minWidth: 0, maxWidth: .infinity)
                    
                    VStack {
                        DemonstrationView();
                    }
                        .frame(minWidth: 0, maxWidth: .infinity);
                }
                
                Button(action: {
                    self.viewRouter.currentPage = "selectionPage";
                }) {
                    Text("Back");
                }
                    .padding(.leading);
            }
            VStack {
                ExternalSignalView();
            }
                .frame(maxHeight: 240)
                .frame(maxWidth: .infinity)
                .background(Color.gray);
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct StageView_Previews: PreviewProvider {
    static var previews: some View {
        StageView(viewRouter: ViewRouter())
    }
}
