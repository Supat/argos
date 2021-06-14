//
//  StageSelectionView.swift
//  Argos
//
//  Created by Supat Saetia on 6/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI

struct StageSelectionView: View {
    
    @ObservedObject var viewRouter: ViewRouter;
    @Environment(\.managedObjectContext) var context

    var categories: [Category] {
        get {
            firstLoad()
            let categories = Category.fetchAllCategories(context: context) ?? []
            return categories
        }
    }
    
    var body: some View {
        NavigationView {
            List(categories, id: \.self) { category in
                ActionCategoryRow(viewRouter: viewRouter, context: context, category: category)
            }
            .navigationBarTitle("Select Action");
            
            InstructionView();
        }
    }
}

struct InstructionView: View {
    var body: some View {
        VStack {
            Text("Instruction appears here")
                .font(.largeTitle);
            
            Text("Additional detail instructions")
                .font(.body);
        }
    }
}

struct StageSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        StageSelectionView(viewRouter: ViewRouter())
    }
}
