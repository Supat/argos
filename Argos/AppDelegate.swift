//
//  AppDelegate.swift
//  Argos
//
//  Created by Supat Saetia on 6/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import UIKit
import SwiftUI
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let persistenceController = PersistenceController.shared;

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce") {
            print("No need to populate database")
        } else {
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("Populate database")
            populateDatabase()
        }


        // Create the SwiftUI view that provides the window contents.
        let contentView = ParentView(viewRouter: ViewRouter())
            .environment(\.managedObjectContext, persistenceController.container.viewContext);

        // Use a UIHostingController as window root view controller.
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIHostingController(rootView: contentView)
        self.window = window
        window.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Argos")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func populateDatabase () {
        let newCategory = Category(context: persistenceController.container.viewContext);
        newCategory.name = "Tekki-shodan";


        let easyVideo = Video(context: persistenceController.container.viewContext);
        easyVideo.url = Bundle.main.url(forResource: "sample_video_1", withExtension: "mp4")?.absoluteString;
        easyVideo.type = "Tekki-shodan";
        easyVideo.name = "sample_video_1"
        easyVideo.ext = "mp4"
        easyVideo.label = "Tekki-shodan"
        easyVideo.confidence = 0.5
        easyVideo.difficulty = 0;
        easyVideo.icon = Bundle.main.url(forResource: "TSiconsBeginner", withExtension: "png")?.absoluteString
        easyVideo.explanation = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi semper dui sed posuere lobortis. Nunc bibendum leo auctor justo vulputate, eu vulputate libero pulvinar. Morbi ut semper justo.";


        let mediumVideo = Video(context: persistenceController.container.viewContext);
        mediumVideo.url = Bundle.main.url(forResource: "video05_02", withExtension: "mov")?.absoluteString;
        mediumVideo.type = "Tekki-shodan";
        mediumVideo.name = "video05_02"
        mediumVideo.ext = "mov"
        mediumVideo.label = "Tekki-shodan"
        mediumVideo.confidence = 0.8
        mediumVideo.difficulty = 1;
        mediumVideo.icon = Bundle.main.url(forResource: "TSiconsMedium", withExtension: "png")?.absoluteString
        mediumVideo.explanation = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi semper dui sed posuere lobortis. Nunc bibendum leo auctor justo vulputate, eu vulputate libero pulvinar. Morbi ut semper justo.";
        
        let hardVideo = Video(context: persistenceController.container.viewContext);
        hardVideo.url = Bundle.main.url(forResource: "video05_02", withExtension: "mov")?.absoluteString;
        hardVideo.type = "Tekki-shodan";
        hardVideo.name = "video05_02"
        hardVideo.ext = "mov"
        hardVideo.label = "Tekki-shodan"
        hardVideo.confidence = 0.8
        hardVideo.difficulty = 2;
        hardVideo.icon = Bundle.main.url(forResource: "TSiconsMedium", withExtension: "png")?.absoluteString
        hardVideo.explanation = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi semper dui sed posuere lobortis. Nunc bibendum leo auctor justo vulputate, eu vulputate libero pulvinar. Morbi ut semper justo.";

        do {
            try persistenceController.container.viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

