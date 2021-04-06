//
//  DownloadManager.swift
//  Podcasts
//
//  Created by Ivan Samalazau on 16/03/2021.
//

import Foundation
import SwiftUI
import FeedKit
import Combine

class DownloadManager: ObservableObject {

    private let urlSession = URLSession.shared
    private var bag = Set<AnyCancellable>()

    @Published var items: [FeedItemMeta] = UserDefaults.standard.feedItems {
        didSet {
            UserDefaults.standard.updateFeedItems(items)
        }
    }

    func isDownloaded(_ item: RSSFeedItem) -> Bool {
        items.contains { $0.id == item.id }
    }

    func startDownloading(_ metaItem: FeedItemMeta) {
//        guard let url = item.playableURL, let metaItem = FeedItemMeta(feedItem: item, state: .downloading(.zero)) else { return nil }

        items.insert(metaItem, at: 0)

        urlSession.downloadTaskPublisher(for: metaItem.remoteURL)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                }
            } receiveValue: { [weak self] output in
                guard let self = self else { return }

                switch output {
                case .completed(let fileURL):
                    print("Finished\n\(fileURL)")
                    metaItem.setReady(fileUrl: fileURL)
                    self.syncItems()

                case .downloading(let progress):
                    metaItem.reportProgress(progress)
                }
            }
            .store(in: &bag)
    }

    func syncItems() {
        UserDefaults.standard.updateFeedItems(items)
    }

    func remove(_ item: FeedItemMeta) throws {
        guard case let ItemMetaState.ready(url) = item.state else { return }

        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print(error)
        }
        items.remove(first: item)
    }
}

extension UserDefaults {

    private enum Key {
        static let feedItems = "feedItems"
    }

    var feedItems: [FeedItemMeta] {
        guard let itemsData = object(forKey: Key.feedItems) as? Data  else { return [] }
        return (try? JSONDecoder().decode([FeedItemMeta].self, from: itemsData)) ?? []
    }

    func updateFeedItems(_ items: [FeedItemMeta]) {
        if let encoded = try? JSONEncoder().encode(items) {
            set(encoded, forKey: Key.feedItems)
        }
    }
}

extension Array where Element: Equatable {

    mutating func remove(first: Element) {
        if let index = firstIndex(of: first) {
            remove(at: index)
        }
    }

    mutating func remove(all: Element) {
        removeAll { $0 == all }
    }
}
