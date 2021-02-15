//
//  PodcastsApp.swift
//  Podcasts
//
//  Created by Ivan Samalazau on 15/02/2021.
//

import SwiftUI

@main
struct PodcastsApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                FeedView()
                    .tabItem {
                        Image(systemName: "music.note.list")
                        Text("Feed")
                    }
                DownloadsView()
                    .tabItem {
                        Image(systemName: "arrow.down.circle")
                        Text("Downloads")
                    }
            }
        }
    }
}
