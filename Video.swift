//
//  Video.swift
//  Argos
//
//  Created by Jin Han on 2021/6/8.
//  Copyright © 2021 Supat Saetia. All rights reserved.
//

import Foundation
import CoreData

extension Video {
    
    static func fetchAllVideoscontext(context: NSManagedObjectContext) -> [Video]? {
        let request: NSFetchRequest = Video.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "url", ascending: true)]
        let videos = try? context.fetch(request)
        return videos
    }
    
    
    static func withCategory(_ category: Category, context: NSManagedObjectContext) -> [Video] {
        let predicate = NSPredicate(format: "belongTo = %@", category)
        let request = NSFetchRequest<Video>(entityName: "Video")
        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(key: "url", ascending: true)]
        let results = try? context.fetch(request)
        return results!
    }
    
    func getName(video: Video) -> String {
        var name = ""
        if video.url!.contains(video.type!) {
            name = video.url!.replacingOccurrences(of: ".\(video.type!)", with: "")
        }
        return name
        
    }
    
}
