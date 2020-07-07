//
//  ParentView.swift
//  Argos
//
//  Created by Supat Saetia on 7/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI

struct ParentView: View {
    
    @ObservedObject var viewRouter: ViewRouter;
    
    var body: some View {
        VStack {
            if viewRouter.currentPage == "selectionPage" {
                StageSelectionView(viewRouter: viewRouter);
            } else if viewRouter.currentPage == "stagePage" {
                StageView(viewRouter: viewRouter);
            }
        }
    }
}

struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView(viewRouter: ViewRouter())
    }
}
