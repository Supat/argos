//
//  StageView.swift
//  Argos
//
//  Created by Supat Saetia on 6/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI

struct StageView: View {
    @Environment(ViewRouter.self) private var router

    let context: StageContext

    @State private var classification = Classification(label: "Not Available", confidence: 0)
    @State private var performanceScore = 0
    @State private var timeRemaining: Int
    @State private var showingReport = false

    private static let targetConfidence = 0.50

    init(context: StageContext) {
        self.context = context
        self._timeRemaining = State(initialValue: context.timeLimit)
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            HStack(spacing: 0) {
                VisionActivityTrackView(context: context, classification: $classification)
                    .frame(maxWidth: .infinity)

                DemonstrationView(videoURL: context.videoURL)
                    .frame(maxWidth: .infinity)
            }

            scoreOverlay
                .padding(.bottom, 25)
        }
        .overlay(alignment: .topLeading) {
            Button("Back") {
                router.returnToSelection()
            }
            .padding(.top, 25)
            .padding(.leading)
        }
        .ignoresSafeArea(edges: .bottom)
        .task { await runStageTimer() }
        .sheet(isPresented: $showingReport, onDismiss: router.returnToSelection) {
            ReportView(performanceScore: performanceScore) {
                showingReport = false
            }
        }
    }

    private var scoreOverlay: some View {
        HStack {
            Spacer()
            stat("Score", value: "\(performanceScore)")
            Spacer()
            stat("Time", value: "\(timeRemaining)")
            Spacer()
        }
    }

    private func stat(_ label: String, value: String) -> some View {
        Text("\(label): \(value)")
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            .background(
                Capsule().fill(.black.opacity(0.75))
            )
    }

    private func runStageTimer() async {
        while timeRemaining > 0 {
            try? await Task.sleep(for: .seconds(1))
            if Task.isCancelled { return }

            timeRemaining -= 1

            if classification.label == context.stageName,
               classification.confidence >= Self.targetConfidence {
                performanceScore += 1
            }
        }
        showingReport = true
    }
}

/// Plain value type for the latest classifier output. Replaces the
/// pair of `@State` strings/doubles previously sloshing across the view tree.
struct Classification: Equatable {
    var label: String
    var confidence: Double
}

#Preview {
    StageView(context: StageContext(
        videoURL: URL(fileURLWithPath: "/dev/null"),
        stageName: "Tekki-shodan",
        difficulty: .beginner
    ))
    .environment(ViewRouter())
}
