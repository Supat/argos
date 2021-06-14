//
//  FirstLoad.swift
//  Argos
//
//  Created by Jin Han on 2021/6/8.
//  Copyright © 2021 Supat Saetia. All rights reserved.
//

import Foundation
import CoreData

extension StageSelectionView {
    func firstLoad() {
        if AppDelegate.isFirstLaunch() {
                print("first load")

                if let path = Bundle.main.path(forResource: "karate_videos", ofType: "json") {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        
                        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                        if let jsonResult = jsonResult as? Dictionary<String, AnyObject>{
                            if let categories = jsonResult["category"] as? [Any] {
                                for category in categories {
                                    
                                    let row = (category as! [String: String])
                                    let name = row["name"]!
                                    print(name)
                                    let newCategory = Category(context: context)
                                    newCategory.name = name
                                    try? context.save()
                                }
                              }
                            if let videos = jsonResult["video"] as? [Any] {
                                
                                for video in videos {
                                    let newVideo = Video(context: context)

                                    let row = (video as! [String: Any])
                                    let belongTo: String = row["belongTo"]! as! String
                                    let type: String = row["type"] as! String
                                    let difficulty: Int? = row["difficulty"] as? Int ?? nil
                                    let url: String = row["url"] as! String
                                    let explanation: String? = row["explanation"] as? String ?? nil
                                    let predicate = NSPredicate(format: "name = %@", belongTo)
                                    let request = NSFetchRequest<Category>(entityName: "Category")
                                    request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
                                    request.predicate = predicate
                                    
                                    let thisCat = try? context.fetch(request)
                                    newVideo.belongTo =  thisCat!.first
                                    
                                    if let difficulty = difficulty {
                                        newVideo.difficulty = Int16(difficulty)
                                    }
                                    
                                    if let explanation = explanation {
                                        newVideo.explanation = explanation
                                    }
                                    
                              //      if let type = type {
                                        newVideo.type = type
                             //       }
                                    
                                    newVideo.url = url
                                    
                                    try? context.save()
                                }
                            }
                        }
                      } catch {
                           // handle error
                            print("Error")
                      }
                }
                else {
                    print("not load")
                }
            }
    }
    
}
