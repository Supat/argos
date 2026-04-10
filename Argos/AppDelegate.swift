//
//  AppDelegate.swift
//  Argos
//
//  Created by Supat Saetia on 6/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//
//  Modernized to the SwiftUI App lifecycle. The file name is preserved
//  because Xcode references this Swift file by path.
//

import SwiftUI

@main
struct ArgosApp: App {
    @State private var router = ViewRouter()
    private let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ParentView()
                .environment(router)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
