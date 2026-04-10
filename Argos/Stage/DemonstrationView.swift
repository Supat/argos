//
//  DemonstrationView.swift
//  Argos
//
//  Created by Supat Saetia on 6/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI

struct DemonstrationView: View {
    let videoURL: URL
    var maxHeight: CGFloat = 640

    var body: some View {
        VStack {
            VideoView(videoURL: videoURL, previewLength: 60)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(height: maxHeight)
                .shadow(color: .black.opacity(0.7), radius: 30, x: 0, y: 2)
                .padding(.horizontal, 20)
                .padding(.top, 20)

            Spacer()
        }
    }
}

#Preview {
    DemonstrationView(videoURL: URL(fileURLWithPath: "/dev/null"))
}
