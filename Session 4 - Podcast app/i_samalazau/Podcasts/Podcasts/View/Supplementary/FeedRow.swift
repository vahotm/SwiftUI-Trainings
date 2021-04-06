//
//  FeedRow.swift
//  Podcasts
//
//  Created by Ivan Samalazau on 22/02/2021.
//

import SwiftUI
import FeedKit

struct FeedRow: View {

    var item: RSSFeedItem
    var publishDateFormatter: RelativeDateTimeFormatter
    var durationFormatter: DateComponentsFormatter
    @EnvironmentObject var downloadManager: DownloadManager

    // Extract to another view with Button/Progress

    // WARNING: multiple sources of truth: metaItem and downloadManager.items
    @ObservedObject var metaItem: FeedItemMeta
//    @State var downloadState: ItemMetaState?

    var body: some View {

        HStack(spacing: 16) {
            if let thumbUrl = item.thumbUrl {
                LoadableImage(url: thumbUrl)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .clipped()
            }
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(publishDateFormatter.localizedString(for: item.pubDate ?? Date(), relativeTo: Date()))
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(durationFormatter.string(from: item.duration) ?? "00:00")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text(item.title ?? "")
                        .font(.body)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    Spacer()

                    switch metaItem.state {
                    case .notDownloaded:
//                        if !downloadManager.isDownloaded(item) {
                            Button {
                                metaItem.reportProgress(.zero)
                                downloadManager.startDownloading(metaItem)
                            } label: {
                                Image(systemName: "arrow.down.square")
                            }
//                        } else {
//                            EmptyView()
//                        }

                    case .downloading(_):
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())

                    default:
                        EmptyView()
                    }
                }
            }
        }
    }
}
