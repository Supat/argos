//
//  StartActionView.swift
//  Argos
//
//  Created by Supat Saetia on 7/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI

struct StartActionView: View {
    var body: some View {
        VStack {
            Text("Action Type")
                .font(.headline);
            
            Text("Are you ready to start?");
            Button(action: {
                print("Start button is pressed");
            }) {
                Text("Start");
            }
        }
    }
}

struct StartActionView_Previews: PreviewProvider {
    static var previews: some View {
        StartActionView()
    }
}
