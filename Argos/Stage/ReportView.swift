//
//  ReportView.swift
//  Argos
//
//  Created by Supat Saetia on 2021/07/16.
//  Copyright © 2021 Supat Saetia. All rights reserved.
//

import SwiftUI

struct ReportView: View {
    let performanceScore: Int
    let onDismiss: () -> Void

    var body: some View {
        Button(action: onDismiss) {
            VStack(spacing: 40) {
                Spacer()
                Text("Score: \(performanceScore)")
                    .font(.largeTitle)
                Text("End Session")
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ReportView(performanceScore: 42, onDismiss: {})
}
