//
//  CountDown.swift
//  Argos
//
//  Created by Jin Han on 2021/6/23.
//  Copyright © 2021 Supat Saetia. All rights reserved.
//

import SwiftUI

/// Reusable inline countdown badge driven by `.task`. Originally used a
/// `Timer.publish` chain that mutated bindings on the main run loop.
struct CountDown: View {
    @Binding var startSession: Bool
    @Binding var startCountDown: Bool

    @State private var secondsRemaining = 5

    var body: some View {
        RoundedRectangle(cornerRadius: 0)
            .overlay(
                Text(secondsRemaining > 0 ? "\(secondsRemaining)" : "Start!")
                    .foregroundStyle(.blue)
                    .font(.largeTitle)
            )
            .frame(width: 200, height: 70)
            .task { await countdown() }
    }

    private func countdown() async {
        while secondsRemaining > 0 {
            try? await Task.sleep(for: .seconds(1))
            if Task.isCancelled { return }
            secondsRemaining -= 1
        }
        startCountDown = false
        secondsRemaining = 5
    }
}
