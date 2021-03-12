//
//  PodcastsApp.swift
//  Podcasts
//
//  Created by Ivan Samalazau on 15/02/2021.
//

import SwiftUI

@main
struct PodcastsApp: App {
    @State var playerFrame = CGRect.zero

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
            .onPreferenceChange(FrameKey.self, perform: { frame in
                self.playerFrame = frame
                print(self.playerFrame)
            })
            .overlay(
                Rectangle()
                    .foregroundColor(.red)
                    .frame(width: playerFrame.width, height: playerFrame.height)
            )
            .environmentObject(PlayerController())
        }
    }
}

struct FrameKey: PreferenceKey {

    typealias Value = CGRect
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
