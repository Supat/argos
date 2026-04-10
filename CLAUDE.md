# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Argos is a native iOS app (SwiftUI + UIKit interop) that uses the device camera, Vision body-pose detection, and bundled CoreML Action Classifiers to score a user's performance of karate kata (currently "Tekki-shodan") at three difficulty levels.

- Swift 5.0, `IPHONEOS_DEPLOYMENT_TARGET = 14.0`, `TARGETED_DEVICE_FAMILY = "1,2"` (iPhone + iPad).
- Bundle id: `com.supatsaetia.Argos`. Uses `NSCameraUsageDescription` and ARKit capability.
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

Camera, Vision, and the CoreML classifiers don't exercise meaningfully in the simulator — prefer a real device for anything touching `ActivityCameraViewController` or the `TekkiShodan*ActivityCameraViewController` subclasses.

## Architecture

### Entry point and navigation

The app uses a classic `AppDelegate` (`@UIApplicationMain`) rather than the SwiftUI `@main App` lifecycle. `AppDelegate.application(_:didFinishLaunchingWithOptions:)` builds a `UIHostingController` around `ParentView` and injects the Core Data `viewContext`.

Navigation is a hand-rolled string-based router, **not** `NavigationStack`:

- `ViewRouter` (`Argos/ViewRouter.swift`) is an `ObservableObject` holding `currentPage: String` plus stage parameters (`videoURL`, `stageTimeLimit`, `stageName`, `stageLevel`). It publishes via a manual `PassthroughSubject` in `objectWillChange` — be aware that assigning these non-`@Published` parameter fields will not trigger view updates on its own.
- `ParentView` switches on `viewRouter.currentPage` between `"selectionPage"` → `StageSelectionView`, `"countdownPage"` → `CountdownView`, `"stagePage"` → `StageView`. New screens are added by extending that switch and pushing a new string constant.
- Screens mutate `viewRouter.currentPage` directly to navigate (e.g. `self.viewRouter.currentPage = "selectionPage"` in `StageView`). There's no back stack.

### Core Data

`PersistenceController` (`Argos/Persistence.swift`) wraps an `NSPersistentContainer(name: "Argos")` and exposes a singleton `shared` plus an in-memory `preview` for SwiftUI previews. The model lives at `Argos.xcdatamodeld/Argos.xcdatamodel/contents` with two entities, both `codeGenerationType="class"` (classes are generated at build time — don't hand-write them):

- `Category { name, has -> Video }`
- `Video { url, name, ext, type, label, confidence, difficulty, icon, explanation, belongTo -> Category }`

`AppDelegate.populateDatabase()` seeds three `Video` rows (easy / medium / hard Tekki-shodan) on the first launch, gated by the `"isAppAlreadyLaunchedOnce"` `UserDefaults` flag. **Changing the seed data on an already-installed app requires clearing that flag (or reinstalling) to see new rows.** Video resources are resolved via `Bundle.main.url(forResource:withExtension:)` — the filenames stored in Core Data come from files bundled in `Video/` (e.g. `video05_02_slow.mp4`, `video05_02.mov`) and icons from `Icon/` / `Image/`.

`StageSelectionView` reads categories with `@FetchRequest`, and `ActionCategoryRow` drills into the associated videos.

### Vision + CoreML activity classification

The classification pipeline is the core of the app:

1. `StageView` hosts `VisionActivityTrackView`, which wraps `ActivityCameraRepresentable` (a `UIViewControllerRepresentable`).
2. Based on `viewRouter.stageName` + `stageLevel`, `ActivityCameraRepresentable.makeUIViewController` picks one of: `TekkiShodanEasyActivityCameraViewController`, `TekkiShodanMediumActivityCameraViewController`, `TekkiShodanHardActivityCameraViewController`, or the fallback `ActivityCameraViewController`. Each subclass is hard-wired to a specific `.mlmodel` file in `Argos/` (`TekkiShodanEasyActionClassifier`, `TekkiShodanMediumActionClassifier`, `TekkiShodanHardActionClassifier`, `HardTekkiShodanClassifier`, `TestActionClassifier`). **Adding a new stage = new view controller subclass + new bundled `.mlmodel` + a new `case` in `ActivityCameraRepresentable.makeUIViewController`.**
3. `ActivityCameraViewController` sets up an `AVCaptureSession`, runs `VNDetectHumanBodyPoseRequest` on each frame, accumulates a window of pose observations, and feeds them into the classifier. It reports `(label, confidence)` back through `ActivityCameraViewDelegate.didRecognizeActivity`, which the Representable's `Coordinator` pushes into the `@Binding` pair on `VisionActivityTrackView`.
4. `StageView` observes those bindings each timer tick: if the classified label matches `targetLabel` (set from `viewRouter.stageName`) with confidence ≥ `targetConfidence` (hard-coded 0.50), it increments `performanceScore`. When the countdown hits zero, `ReportView` is presented as a sheet.

Note the `VNRecognizedPointsObservation` API used in `ActivityCameraViewController` is the iOS 14-era name; it's deprecated in later SDKs in favor of `VNHumanBodyPoseObservation`, but the code still targets the old symbol.

### Directory layout cheatsheet

- `Argos/` — app sources, `Info.plist`, `Assets.xcassets`, bundled `.mlmodel` files, `Experience.rcproject` (RealityKit), `character/robot.usdz`.
- `Argos/Stage/` — in-session UI + camera/Vision controllers (one per difficulty).
- `Argos/StageSelection/` — browse categories/videos, launch a stage.
- `Argos/VideoPlayer/`, `Argos/Component/`, `Argos/ExternalSignal/` — small reusable views.
- `Argos.xcdatamodeld/` — Core Data model.
- `Video/`, `Image/`, `Icon/` — raw assets referenced from Core Data seed data and the asset catalog.
- `ArgosTests/`, `ArgosUITests/` — XCTest targets (the default Xcode stubs).
- `ModalGraphView.swift` (at repo root) — a stray SwiftUI file compiled into the main target via `PBXBuildFile`; it is **not** inside `Argos/`, so keep that in mind when moving or renaming it.

## Conventions observed in this codebase

- SwiftUI views use trailing semicolons and explicit `self.` in closures throughout — match the existing style when editing rather than reformatting.
- String literals are the source of truth for routes and stage names (e.g. `"Tekki-shodan"`, `"selectionPage"`). Changing one requires grepping for every matching literal — there are no enums wrapping them.
- `ViewRouter` stage parameters are force-unwrapped at the read site (e.g. `self.targetLabel = viewRouter.stageName!`, `print("Stage: " + self.stageName!)`). Callers must set them before switching `currentPage` to `"stagePage"`.
