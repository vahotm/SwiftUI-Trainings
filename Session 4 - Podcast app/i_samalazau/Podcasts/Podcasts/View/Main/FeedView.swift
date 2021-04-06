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
    @EnvironmentObject var playerController: PlayerController
    @EnvironmentObject var downloadManager: DownloadManager

    private var dateFormatter: RelativeDateTimeFormatter {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        return formatter
    }

    private var durationFormatter: DateComponentsFormatter {
        let f = DateComponentsFormatter()
        f.unitsStyle = .abbreviated
        f.allowedUnits = [.hour, .minute]
        return f
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                List(feedDataSource.items) { item in
                    FeedRow(item: item, publishDateFormatter: dateFormatter,
                            durationFormatter: durationFormatter,
                            metaItem: FeedItemMeta(feedItem: item, state: .notDownloaded)!)
//                        .onTapGesture {
//                            withAnimation {
//                                try? playerController.startPlay(item: item)
//                            }
//                        }
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle(Text(feedDataSource.feed?.title ?? ""))
                .onAppear(perform: feedDataSource.fetchFeed)

                if playerController.state.isActive {
                    PlayerView()
                        .frame(maxWidth: .infinity)
                        .transition(.move(edge: .bottom))
                }
            }
        }
    }

}
