//
//  Category.swift
//  Argos
//
//  Created by Jin Han on 2021/6/8.
//  Copyright © 2021 Supat Saetia. All rights reserved.
//

import Combine
import CoreData

extension Category {
    
    static func fetchAllCategories(context: NSManagedObjectContext) -> [Category]? {

        let request: NSFetchRequest = Category.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let categories = try? context.fetch(request)
        return categories
    }

}

