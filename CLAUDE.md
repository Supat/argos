# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Argos is a native iOS/iPadOS app (SwiftUI + UIKit interop) that uses the device camera, Vision body-pose detection, and bundled CoreML Action Classifiers to score a user's performance of karate kata (currently "Tekki-shodan") at three difficulty levels.

- Swift 5 toolchain (Xcode 15+), `IPHONEOS_DEPLOYMENT_TARGET = 17.0`, `TARGETED_DEVICE_FAMILY = "1,2"` (iPhone + iPad).
- Uses the iOS 17 Observation framework (`@Observable`) and `NavigationStack`.
- Bundle id: `com.supatsaetia.Argos`. Requires `arm64` + `arkit`. `NSCameraUsageDescription` is set in `Argos/Info.plist`.
- No external package manager: no `Package.swift`, `Podfile`, or `Cartfile`. Everything is vendored inside the Xcode project.

## Build / Run / Test

This is an Xcode project (`Argos.xcodeproj`) — there is no SwiftPM manifest. Use `xcodebuild` or open in Xcode. The shared scheme is `Argos` (`Argos.xcodeproj/xcshareddata/xcschemes/Argos.xcscheme`).

```sh
# Build for simulator
xcodebuild -project Argos.xcodeproj -scheme Argos \
  -destination 'platform=iOS Simulator,name=iPhone 15' build

# Run unit + UI tests
xcodebuild -project Argos.xcodeproj -scheme Argos \
  -destination 'platform=iOS Simulator,name=iPhone 15' test

# Run a single test (XCTest bundle/class/method selector)
xcodebuild -project Argos.xcodeproj -scheme Argos \
  -destination 'platform=iOS Simulator,name=iPhone 15' \
  -only-testing:ArgosTests/ArgosTests/testExample test
```

Camera, Vision, and the CoreML classifiers don't exercise meaningfully in the simulator — prefer a real device for anything touching `ActivityCameraViewController` or its `TekkiShodan*` subclasses.

## Architecture

### Entry point and navigation

`AppDelegate.swift` defines the SwiftUI app entry point — `@main struct ArgosApp: App` (the file name is preserved because Xcode references it by path). It builds a `WindowGroup`, injects a single `ViewRouter` via the iOS 17 `.environment(_:)` overload, and provides the Core Data `viewContext`.

Navigation is a small typed router, not a `NavigationStack` path:

- `ViewRouter` (`Argos/ViewRouter.swift`) is `@Observable` and exposes `var route: Route` plus three intent methods (`startCountdown`, `enterStage`, `returnToSelection`). `Route` is an enum with `.selection`, `.countdown(StageContext)`, `.stage(StageContext)`. `StageContext` (a `Hashable` value type) carries `videoURL`, `stageName`, `difficulty`.
- `StageDifficulty` is the typed replacement for the raw `Int16` "level" — it owns the icon-asset name and per-level `timeLimit`.
- `ParentView.swift` reads the router from the environment with `@Environment(ViewRouter.self)` and switches on `router.route` to show `StageSelectionView`, `CountdownView`, or `StageView`.
- Within the selection screen, `StageSelectionView` wraps content in a `NavigationStack` and `ActionCategoryRow` uses `NavigationLink { ... } label: { ... }`. The router only takes over once the user taps "Start" in `StartActionView`, which calls `router.startCountdown(with:)`.

### Core Data

`PersistenceController` (`Argos/Persistence.swift`) wraps `NSPersistentContainer(name: "Argos")` and exposes a singleton `shared` plus a `@MainActor` in-memory `preview` for SwiftUI previews. The model lives at `Argos.xcdatamodeld/Argos.xcdatamodel/contents` with two entities, both `codeGenerationType="class"` (classes are generated at build time — don't hand-write them):

- `Category { name, has -> Video }`
- `Video { url, name, ext, type, label, confidence, difficulty, icon, explanation, belongTo -> Category }`

Seed data is declared once in the `SeedData` enum (`Persistence.swift`) and reused by both the live store and the preview store. `PersistenceController.init(inMemory:)` calls `seedFirstLaunchIfNeeded()`, gated by the `"isAppAlreadyLaunchedOnce"` `UserDefaults` flag. **Changing the seed data on an already-installed app requires clearing that flag (or reinstalling) to see new rows.** Video and icon resources are resolved via `Bundle.main.url(forResource:withExtension:)` from files in `Video/` / `Icon/`.

`StageSelectionView` reads categories with `@FetchRequest`, and `ActionCategoryRow` drills into the associated videos.

### Vision + CoreML activity classification

The classification pipeline is the core of the app and was deduplicated to a base class + thin subclasses:

1. `StageView` hosts `VisionActivityTrackView`, which wraps a private `ActivityCameraRepresentable` (a `UIViewControllerRepresentable`).
2. Based on `context.stageName` + `context.difficulty`, `ActivityCameraRepresentable.makeUIViewController` picks one of: `TekkiShodanEasyActivityCameraViewController`, `TekkiShodanMediumActivityCameraViewController`, `TekkiShodanHardActivityCameraViewController`, or the fallback `ActivityCameraViewController` base class.
3. `ActivityCameraViewController` (the base class) owns the `AVCaptureSession`, preview layer, `VNDetectHumanBodyPoseRequest`, and the rolling pose buffer. It exposes two override hooks:
   - `var predictionWindowSize: Int` — how many `VNHumanBodyPoseObservation` frames to feed each prediction.
   - `func prediction(from poses: MLMultiArray) throws -> (label: String, confidence: Double)?` — instantiate the bundled CoreML model and run a prediction.
   The three TekkiShodan subclasses are now ~15 lines each — they only override these two hooks. **Adding a new stage = new subclass + new bundled `.mlmodel` + a new `case` in `ActivityCameraRepresentable.makeViewController`.**
4. The base class delivers results back through `ActivityCameraViewDelegate.didRecognizeActivity` (always dispatched to the main queue), which `ActivityCameraRepresentable.Coordinator` writes to a `@Binding<Classification>` on `VisionActivityTrackView`.
5. `StageView` runs its countdown via `.task { await runStageTimer() }` (`Task.sleep(for: .seconds(1))`); on each tick, if `classification.label == context.stageName` and `confidence >= 0.50`, it increments `performanceScore`. When the countdown hits zero, `ReportView` is presented as a sheet.

The pipeline was migrated from the deprecated `VNRecognizedPointsObservation` to `VNHumanBodyPoseObservation`. `keypointsMultiArray()` continues to feed the model.

### Directory layout cheatsheet

- `Argos/` — app sources, `Info.plist`, `Assets.xcassets`, bundled `.mlmodel` files, `Experience.rcproject` (RealityKit), `character/robot.usdz`. `AppDelegate.swift` here is the SwiftUI `@main App`, not a `UIApplicationDelegate`.
- `Argos/Stage/` — in-session UI + camera/Vision controllers (one per difficulty, all subclasses of `ActivityCameraViewController`).
- `Argos/StageSelection/` — browse categories/videos, launch a stage. `StartActionView` houses the kata description data in a structured `KataDescription` enum.
- `Argos/VideoPlayer/`, `Argos/Component/`, `Argos/ExternalSignal/` — small reusable views.
- `Argos.xcdatamodeld/` — Core Data model.
- `Video/`, `Image/`, `Icon/` — raw assets referenced from Core Data seed data and the asset catalog.
- `ArgosTests/`, `ArgosUITests/` — XCTest targets.
- `ModalGraphView.swift` (at repo root) — a stray SwiftUI file compiled into the main target via `PBXBuildFile`; it is **not** inside `Argos/`, so keep that in mind when moving or renaming it.

## Conventions observed in this codebase

- The project uses the iOS 17 Observation macro (`@Observable`) — read the router with `@Environment(ViewRouter.self)`, not `@ObservedObject`. Don't reintroduce `ObservableObject` / `@Published` boilerplate.
- Prefer `Task.sleep(for: .seconds(...))` inside `.task { ... }` over `Timer.publish` for view-local timers.
- Routing literals like `"Tekki-shodan"` are still string-based on the model side because they come out of Core Data; the navigation graph itself is now strongly typed via `Route` / `StageContext` / `StageDifficulty`. When adding a new kata, prefer extending `StageDifficulty` and `Route` rather than introducing new magic strings.
- Camera view controllers should subclass `ActivityCameraViewController` and override only `predictionWindowSize` + `prediction(from:)`. Don't duplicate the capture session setup.
