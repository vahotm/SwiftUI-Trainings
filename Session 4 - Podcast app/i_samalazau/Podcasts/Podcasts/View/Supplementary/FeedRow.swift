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
    var formatter: RelativeDateTimeFormatter {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        return formatter
    }

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            if let thumbUrl = item.thumbUrl {
                LoadableImage(url: thumbUrl)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .clipped()
            }
            VStack(alignment: .leading, spacing: 8) {
                Text(formatter.localizedString(for: item.pubDate ?? Date(), relativeTo: Date()))
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(item.title ?? "")
                    .font(.body)
                    .foregroundColor(.primary)
                //            Spacer()
                //            Text("\(item.count)")
                //                .font(.subheadline)
            }
        }
    }
}
