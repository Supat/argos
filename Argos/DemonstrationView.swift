//
//  DemonstrationView.swift
//  Argos
//
//  Created by Supat Saetia on 6/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI

struct DemonstrationView: View {
    var body: some View {
        VStack {
            Image(systemName: "play.circle.fill").resizable()
                .frame(width: 120.0, height: 120.0)
            Text("Demonstration video clip appears here.")
        }
    }
}

struct DemonstrationView_Previews: PreviewProvider {
    static var previews: some View {
        DemonstrationView()
    }
}
