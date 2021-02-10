//
//  BullshitModel.swift
//  Training 2
//
//  Created by Ivan Samalazau on 24/01/2021.
//

import Foundation
import UIKit

struct BullshitItem: Hashable, Codable, Identifiable {
    
    var title: String
    var count: Int
    var imageUrl: URL

    var id: Int

    init(title: String, count: Int = 0, id: Int = Int.random(in: 1...Int.max)) {
        self.title = title
        self.count = count
        self.id = id
        self.imageUrl = Self.imageUrl(from: id)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        count = try container.decode(Int.self, forKey: .count)
        imageUrl = Self.imageUrl(from: id)
    }
}

private extension BullshitItem {

    static func imageUrl(from id: Int) -> URL {
        URL(string: "https://loremflickr.com/320/240/cat?lock=\(id)")!
    }
}
