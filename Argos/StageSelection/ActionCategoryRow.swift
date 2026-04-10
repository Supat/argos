//
//  ActionCategoryRow.swift
//  Argos
//
//  Created by Supat Saetia on 7/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI

struct ActionCategoryRow: View {
    let category: Category

    @FetchRequest(
        sortDescriptors: [SortDescriptor(\Video.difficulty, order: .forward)],
        predicate: NSPredicate(format: "type == %@", "Tekki-shodan"),
        animation: .default
    )
    private var videos: FetchedResults<Video>

    var body: some View {
        VStack(alignment: .leading) {
            Text(category.name ?? "Unknown")
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(videos) { video in
                        NavigationLink {
                            StartActionView(video: video, category: category)
                        } label: {
                            ActionCategoryItem(video: video)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .frame(height: 185)
        }
    }
}

struct ActionCategoryItem: View {
    let video: Video

    private var iconName: String {
        StageDifficulty(rawValue: video.difficulty)?.iconAssetName ?? "person.fill"
    }

    var body: some View {
        VStack(alignment: .leading) {
            Image(iconName)
                .resizable()
                .renderingMode(.original)
                .frame(width: 120, height: 120)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 10))

            Text("Difficulty Level: \(video.difficulty)")
                .foregroundStyle(.primary)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}
