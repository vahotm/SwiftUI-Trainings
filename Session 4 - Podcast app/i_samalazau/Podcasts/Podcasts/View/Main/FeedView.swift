//
//  FeedView.swift
//  Podcasts
//
//  Created by Ivan Samalazau on 15/02/2021.
//

import SwiftUI
import FeedKit

struct FeedView: View {
    @ObservedObject var feedDataSource = FeedDataSource(url: "https://oper.ru/video.xml")!
//    @ObservedObject var feedDataSource = FeedDataSource(url: "https://podcast.tema.ru/yandex.xml")!
    @EnvironmentObject var playerController: PlayerController

    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
//                Text("\(playerController.player.progress)")
//                Slider(value: playerController.player.progress)
                List(feedDataSource.items) { item in
                    FeedRow(item: item)
                        .onTapGesture {
                            withAnimation {
                                try? playerController.startPlay(item: item)
                            }
                        }
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle(Text(feedDataSource.feed?.title ?? ""))
                .onAppear(perform: feedDataSource.fetchFeed)

                if playerController.state != .uninitialized {
                    PlayerView()
                        .frame(maxWidth: .infinity)
                        .transition(.move(edge: .bottom))
                }
            }
        }
    }

}
