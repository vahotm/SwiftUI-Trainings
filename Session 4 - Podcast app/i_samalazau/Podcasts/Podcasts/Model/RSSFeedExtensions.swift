//
//  RSSFeedExtensions.swift
//  Podcasts
//
//  Created by Ivan Samalazau on 02/03/2021.
//

import FeedKit
import Foundation

extension RSSFeedItem {

    var playableURL: URL? {
        guard let urlString = media?.mediaContents?.first?.attributes?.url,
              let actualURL = URL(string: urlString) else { return nil }
        print(actualURL)
        return actualURL
    }

    var duration: TimeInterval {
        TimeInterval(media?.mediaContents?.first?.attributes?.duration ?? 0)
    }

    var thumbUrl: URL? {
        guard let urlString = iTunes?.iTunesImage?.attributes?.href,
              let url = URL(string: urlString) else { return nil }
        return url
    }
}
