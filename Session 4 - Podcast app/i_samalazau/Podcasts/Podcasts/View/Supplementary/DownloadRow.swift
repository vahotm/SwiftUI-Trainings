//
//  DownloadRow.swift
//  Podcasts
//
//  Created by Ivan Samalazau on 23/03/2021.
//

import SwiftUI
import FeedKit

struct DownloadRow: View {

    var item: FeedItemMeta
    var durationFormatter: DateComponentsFormatter

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()

    var body: some View {

        HStack(alignment: .center, spacing: 16) {
            LoadableImage(url: item.thumbURL)
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                .clipped()
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(dateFormatter.string(from: item.downloadDate))
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
//                    Text(durationFormatter.string(from: item.duration) ?? "00:00")
//                        .font(.footnote)
//                        .foregroundColor(.secondary)
                }
                Text(item.title)
                    .font(.body)
                    .foregroundColor(.primary)
                    .lineLimit(3)
//                if case let FeedItemMeta
//                ProgressView(value: item.s, total: )
            }
        }
    }
}
