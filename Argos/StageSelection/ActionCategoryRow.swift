//
//  ActionCategoryRow.swift
//  Argos
//
//  Created by Supat Saetia on 7/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI

struct ActionCategoryRow: View {
    
    @ObservedObject var viewRouter: ViewRouter;
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Action Type")
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5);
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    NavigationLink(
                        destination: StartActionView(viewRouter: viewRouter)
                    ) {
                        ActionCategoryItem();
                    }
                    NavigationLink(
                        destination: StartActionView(viewRouter: viewRouter)
                    ) {
                        ActionCategoryItem();
                    }
                    NavigationLink(
                        destination: StartActionView(viewRouter: viewRouter)
                    ) {
                        ActionCategoryItem();
                    }
                    NavigationLink(
                        destination: StartActionView(viewRouter: viewRouter)
                    ) {
                        ActionCategoryItem();
                    }
                }
            }
            .frame(height: 185);
        }
    }
}

struct ActionCategoryItem: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: ("person.fill")).resizable()
                .renderingMode(.original)
                .frame(width: 120.0, height: 120.0)
                .background(Color.gray)
                .cornerRadius(10)
                
            Text("Difficulty Level")
                .foregroundColor(.primary)
                .font(.caption);
        }
        .padding(.leading, 15);
    }
}

struct ActionCategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        ActionCategoryRow(viewRouter: ViewRouter())
    }
}
