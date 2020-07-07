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
        ZStack(alignment: .topLeading) {
            HStack {
                VStack {
                    BodyTrackedView()
                }
                    .frame(minWidth: 0, maxWidth: .infinity);
                
                VStack {
                    DemonstrationView()
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
    }
}

struct StageView_Previews: PreviewProvider {
    static var previews: some View {
        StageView(viewRouter: ViewRouter())
    }
}
