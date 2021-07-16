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
    @Environment(\.managedObjectContext) private var viewContext;
    
    var body: some View {
        ZStack {
            VStack {
                switch viewRouter.currentPage{
                case "selectionPage":
                    StageSelectionView(viewRouter: viewRouter);
                case "stagePage":
                    StageView(viewRouter: viewRouter);
                case "countdownPage":
                    CountdownView(viewRouter: viewRouter)
                default:
                    EmptyView()
                }
            }
        }
    }
}

struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView(viewRouter: ViewRouter())
    }
}
