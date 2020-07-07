//
//  StageSelectionView.swift
//  Argos
//
//  Created by Supat Saetia on 6/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI

struct StageSelectionView: View {
    var body: some View {
        NavigationView {
            List {
                ActionCategoryRow();
                ActionCategoryRow();
                ActionCategoryRow();
                ActionCategoryRow();
                ActionCategoryRow();
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
        StageSelectionView()
    }
}
