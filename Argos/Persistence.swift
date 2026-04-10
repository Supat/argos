//
//  Persistence.swift
//  Argos
//
//  Created by Supat Saetia on 2021/07/01.
//  Copyright © 2021 Supat Saetia. All rights reserved.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    @MainActor
    static let preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        SeedData.tekkiShodan.seed(into: controller.container.viewContext)
        return controller
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Argos")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Unresolved Core Data error: \(error)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true

        if !inMemory {
            seedFirstLaunchIfNeeded()
        }
    }

    private func seedFirstLaunchIfNeeded() {
        let key = "isAppAlreadyLaunchedOnce"
        let defaults = UserDefaults.standard

        guard defaults.string(forKey: key) == nil else { return }
        defaults.set(true, forKey: key)

        SeedData.tekkiShodan.seed(into: container.viewContext)
    }
}

/// Declarative seed data so view-context bootstrapping is reusable between
/// the live store and the SwiftUI preview store.
enum SeedData {
    struct VideoSeed {
        let name: String
        let ext: String
        let label: String
        let confidence: Double
        let difficulty: Int16
        let iconName: String
        let explanation: String
    }

    struct CategorySeed {
        let name: String
        let videos: [VideoSeed]
    }

    static let tekkiShodan = CategorySeed(
        name: "Tekki-shodan",
        videos: [
            VideoSeed(
                name: "video05_02_slow",
                ext: "mp4",
                label: "Tekki-shodan",
                confidence: 0.5,
                difficulty: 0,
                iconName: "TSiconsBeginner",
                explanation: lorem
            ),
            VideoSeed(
                name: "video05_02",
                ext: "mov",
                label: "Tekki-shodan",
                confidence: 0.8,
                difficulty: 1,
                iconName: "TSiconsMedium",
                explanation: lorem
            ),
            VideoSeed(
                name: "video05_02",
                ext: "mov",
                label: "TekkiShodan",
                confidence: 0.8,
                difficulty: 2,
                iconName: "TSiconsMedium",
                explanation: lorem
            ),
        ]
    )
}

extension SeedData.CategorySeed {
    func seed(into context: NSManagedObjectContext) {
        let category = Category(context: context)
        category.name = name

        for seed in videos {
            let video = Video(context: context)
            video.name = seed.name
            video.ext = seed.ext
            video.url = Bundle.main.url(forResource: seed.name, withExtension: seed.ext)?.absoluteString
            video.type = name
            video.label = seed.label
            video.confidence = seed.confidence
            video.difficulty = seed.difficulty
            video.icon = Bundle.main.url(forResource: seed.iconName, withExtension: "png")?.absoluteString
            video.explanation = seed.explanation
        }

        do {
            try context.save()
        } catch {
            assertionFailure("Failed to seed Core Data store: \(error)")
        }
    }
}

private let lorem = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi semper dui sed \
posuere lobortis. Nunc bibendum leo auctor justo vulputate, eu vulputate \
libero pulvinar. Morbi ut semper justo.
"""
