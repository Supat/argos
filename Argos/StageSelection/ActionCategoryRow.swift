//
//  ActionCategoryRow.swift
//  Argos
//
//  Created by Supat Saetia on 7/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI

struct ActionCategoryRow: View {
    
    @ObservedObject var viewRouter: ViewRouter;
    @Environment(\.managedObjectContext) private var viewContext;
    var category: Category;

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Video.type, ascending: true)],
        predicate: NSPredicate(format: "type == %@", "Tekki-shodan"),
        animation: .default)
    private var videos: FetchedResults<Video>
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(category.name!)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5);
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(videos) { video in
                        NavigationLink(
                            destination: StartActionView(viewRouter: viewRouter, video: video, category: category)
                        ) {
                            ActionCategoryItem(video: video);
                        }
                    }
                }
            }
            .frame(height: 185);
        }
    }
}

struct ActionCategoryItem: View {
    let video: Video;
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: ("person.fill")).resizable()
                .renderingMode(.original)
                .frame(width: 120.0, height: 120.0)
                .background(Color.gray)
                .cornerRadius(10)
                
            Text("Difficulty Level: \(video.difficulty)")
                .foregroundColor(.primary)
                .font(.caption);
        }
        .padding(.leading, 15);
    }
}

//struct ActionCategoryRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ActionCategoryRow(viewRouter: ViewRouter())
//    }
//}
