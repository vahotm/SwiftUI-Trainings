//
//  FeedItemMeta.swift
//  Podcasts
//
//  Created by Ivan Samalazau on 16/03/2021.
//

import Foundation
import FeedKit
import AVFoundation

enum ItemMetaState: Equatable {

    case notDownloaded
    case downloading(DownloadProgress)
    case ready(URL)

    static func state(from url: URL?) -> Self {
        if let url = url {
            return .ready(url)
        } else {
            return .downloading(.zero)
        }
    }
}

class FeedItemMeta: ObservableObject, Identifiable {

    let title: String
    let id: String
    let remoteURL: URL
    let thumbURL: URL
    let downloadDate: Date

    @Published private(set) var state: ItemMetaState

    init?(feedItem: RSSFeedItem, state: ItemMetaState, date: Date = Date()) {
        guard let title = feedItem.title, let remoteURL = feedItem.playableURL, let thumbURL = feedItem.thumbUrl else { return nil }

        self.title = title
        self.id = feedItem.id
        self.remoteURL = remoteURL
        self.thumbURL = thumbURL
        self.downloadDate = date
        self.state = state
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        id = try container.decode(String.self, forKey: .id)
        remoteURL = try container.decode(URL.self, forKey: .remoteURL)
        thumbURL = try container.decode(URL.self, forKey: .thumbURL)
        downloadDate = try container.decode(Date.self, forKey: .downloadDate)
        state = .state(from: try container.decodeIfPresent(URL.self, forKey: .localFileURL))
    }

    func setReady(fileUrl: URL) {
        state = .ready(fileUrl)
    }

    func reportProgress(_ progress: DownloadProgress) {
        state = .downloading(progress)
    }
}

extension FeedItemMeta: Equatable {

    static func == (lhs: FeedItemMeta, rhs: FeedItemMeta) -> Bool {
        lhs.id == rhs.id
    }
}

extension FeedItemMeta: Comparable {

    static func < (lhs: FeedItemMeta, rhs: FeedItemMeta) -> Bool {
        switch (lhs.state, rhs.state) {
        case (.downloading, .ready):
            return true
        case (.ready, .downloading):
            return false
        default:
            return lhs.downloadDate < rhs.downloadDate
        }
    }
}

extension FeedItemMeta: Codable {

    enum CodingKeys: CodingKey {
        case title, id, remoteURL, thumbURL, localFileURL, downloadDate
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(id, forKey: .id)
        try container.encode(remoteURL, forKey: .remoteURL)
        try container.encode(thumbURL, forKey: .thumbURL)
        try container.encode(downloadDate, forKey: .downloadDate)

        if case let ItemMetaState.ready(url) = state {
            try container.encode(url, forKey: .localFileURL)
        }
    }
}

extension FeedItemMeta {

    func getDuration(completion: @escaping (Double) -> Void) {
        guard case let ItemMetaState.ready(fileUrl) = state else {
            completion(0)
            return
        }
        let audioAsset = AVURLAsset(url: fileUrl, options: nil)

        audioAsset.loadValuesAsynchronously(forKeys: ["duration"]) {
            var error: NSError?
            let status = audioAsset.statusOfValue(forKey: "duration", error: &error)
            switch status {
            case .loaded:
                let duration = audioAsset.duration
                let durationInSeconds = CMTimeGetSeconds(duration)
                completion(durationInSeconds)
                break
            default:
                completion(0)
                break
            }
        }
    }
}
