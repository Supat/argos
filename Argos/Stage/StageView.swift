//
//  StageView.swift
//  Argos
//
//  Created by Supat Saetia on 6/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI

struct StageView: View {
    var body: some View {
        HStack {
            VStack {
                BodyTrackedView()
            }
                .frame(minWidth: 0, maxWidth: .infinity);
            
            VStack {
                DemonstrationView()
            }
                .frame(minWidth: 0, maxWidth: .infinity);
        }
    }
}

struct StageView_Previews: PreviewProvider {
    static var previews: some View {
        StageView()
    }
}
