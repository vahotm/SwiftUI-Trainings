//
//  FeedDataSource.swift
//  Podcasts
//
//  Created by Ivan Samalazau on 15/02/2021.
//

import Foundation
import SwiftUI
import Combine
import FeedKit

class FeedDataSource: ObservableObject {

    @Published var feed: RSSFeed? {
        didSet {
            items = feed?.items ?? []
        }
    }
    @Published private(set) var items: [RSSFeedItem]
    var cancellable: AnyCancellable?

    private let parser: FeedParser

    init?(url: String) {
        items = []
        guard let feedURL = URL(string: url) else { return nil }
        parser = FeedParser(URL: feedURL)
    }

    func fetchFeed() {
        cancellable = parser.fetch(queue: .global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .tryCompactMap { (feed) -> RSSFeed? in
                guard case let Feed.rss(rssFeed) = feed else { return nil }
                return rssFeed
            }
            .replaceError(with: nil)
//            .compactMap { feed in
//                guard case let Feed.rss(rssFeed) = feed else { return nil }
//                return rssFeed
//            }
            .assign(to: \.feed, on: self)

//            .sink(receiveCompletion: { result in
//            }, receiveValue: { [weak self] feed in
//                guard case let Feed.rss(rssFeed) = feed else { return }
//                self?.feed = rssFeed
//            })
    }

}

extension FeedParser {

    func fetch(queue: DispatchQueue) -> Future<Feed, ParserError> {
        return Future() { promise in
            self.parseAsync(queue: queue) { (result) in
                promise(result)
            }
        }
    }
}

extension RSSFeedItem: Identifiable {

    public var id: String { guid!.value! }
}
