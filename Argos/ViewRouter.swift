//
//  ViewRouter.swift
//  Argos
//
//  Created by Supat Saetia on 7/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import Foundation
import Observation

/// Difficulty level for a stage.
enum StageDifficulty: Int16, CaseIterable, Identifiable {
    case beginner = 0
    case medium = 1
    case advanced = 2

    var id: Int16 { rawValue }

    init?(_ raw: Int16) {
        self.init(rawValue: raw)
    }

    var iconAssetName: String {
        switch self {
        case .beginner: "TSiconsBeginner"
        case .medium:   "TSiconsMedium"
        case .advanced: "TSiconsAdvance"
        }
    }

    /// Time limit, in seconds, that the user has on stage.
    var timeLimit: Int {
        switch self {
        case .beginner: 120
        case .medium, .advanced: 60
        }
    }
}

/// Everything needed to launch and score a single training session.
struct StageContext: Equatable, Hashable {
    var videoURL: URL
    var stageName: String
    var difficulty: StageDifficulty

    var timeLimit: Int { difficulty.timeLimit }
}

/// The set of top-level destinations the app can show. Replaces the old
/// stringly-typed `currentPage` mechanism.
enum Route: Hashable {
    case selection
    case countdown(StageContext)
    case stage(StageContext)
}

/// Single source of truth for navigation state. Uses the iOS 17 `@Observable`
/// macro so SwiftUI views can read individual properties without `ObservableObject`
/// boilerplate.
@Observable
final class ViewRouter {
    var route: Route = .selection

    func startCountdown(with context: StageContext) {
        route = .countdown(context)
    }

    func enterStage(with context: StageContext) {
        route = .stage(context)
    }

    func returnToSelection() {
        route = .selection
    }
}
