//
//  ParentView.swift
//  Argos
//
//  Created by Supat Saetia on 7/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI

struct ParentView: View {
    @Environment(ViewRouter.self) private var router

    var body: some View {
        switch router.route {
        case .selection:
            StageSelectionView()
        case .countdown(let context):
            CountdownView(context: context)
        case .stage(let context):
            StageView(context: context)
        }
    }
}

#Preview {
    ParentView()
        .environment(ViewRouter())
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
