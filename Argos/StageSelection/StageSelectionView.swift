//
//  StageSelectionView.swift
//  Argos
//
//  Created by Supat Saetia on 6/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI

struct StageSelectionView: View {
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\Category.name, order: .forward)]
    )
    private var categories: FetchedResults<Category>

    var body: some View {
        NavigationStack {
            List {
                ForEach(categories) { category in
                    ActionCategoryRow(category: category)
                        .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Select Action")
        }
    }
}

#Preview {
    StageSelectionView()
        .environment(ViewRouter())
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
