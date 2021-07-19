//
//  TekkiShodanView.swift
//  Argos
//
//  Created by 张新婕 on 2021/06/25.
//  Copyright © 2021 Supat Saetia. All rights reserved.
//

import SwiftUI

struct TekkiShodanView: View {
    var body: some View {
        Image("TS01")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 750, height: 750)
    }
}

struct TekkiShodanView_Previews: PreviewProvider {
    static var previews: some View {
        TekkiShodanView()
    }
}
