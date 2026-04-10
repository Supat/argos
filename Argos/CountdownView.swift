//
//  CountdownView.swift
//  Argos
//
//  Created by Supat Saetia on 2021/07/16.
//  Copyright © 2021 Supat Saetia. All rights reserved.
//

import SwiftUI

struct CountdownView: View {
    @Environment(ViewRouter.self) private var router

    let context: StageContext

    @State private var secondsRemaining = 5

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            Text(displayText)
                .font(.system(size: 96, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
                .padding(.horizontal, 32)
                .padding(.vertical, 12)
                .background(
                    Capsule().fill(.black.opacity(0.75))
                )
        }
        .task {
            await runCountdown()
        }
    }

    private var displayText: String {
        switch secondsRemaining {
        case 5, 4: "Ready..."
        case 3, 2: "Set.."
        case 1: "Go!"
        default: " "
        }
    }

    private func runCountdown() async {
        while secondsRemaining > 0 {
            try? await Task.sleep(for: .seconds(1))
            if Task.isCancelled { return }
            secondsRemaining -= 1
        }
        router.enterStage(with: context)
    }
}

#Preview {
    CountdownView(context: StageContext(
        videoURL: URL(fileURLWithPath: "/dev/null"),
        stageName: "Tekki-shodan",
        difficulty: .beginner
    ))
    .environment(ViewRouter())
}
