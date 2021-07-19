//
//  TekkiShodanView2.swift
//  Argos
//
//  Created by kylab on 2021/07/16.
//  Copyright © 2021 Supat Saetia. All rights reserved.
//

import SwiftUI

struct TekkiShodanView2: View {
    var body: some View {
        Image("TS02")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 750, height: 750)
    }
}

struct TekkiShodanView2_Previews: PreviewProvider {
    static var previews: some View {
        TekkiShodanView2()
    }
}
