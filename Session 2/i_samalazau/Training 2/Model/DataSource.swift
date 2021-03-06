//
//  DataSource.swift
//  Training 2
//
//  Created by Ivan Samalazau on 24/01/2021.
//

import Foundation
import SwiftUI

class DataSource: ObservableObject {

    @Published var items: [BullshitItem]

    init() {
        items = DataSource.load("bullshitData.json")
    }

//    func item(by id: Int) -> BullshitItem? {
//        items.first(where: { $0.id == id })
//    }

    func index(of item: BullshitItem) -> Int {
        items.firstIndex(where: { $0.id == item.id }) ?? 0
    }

    static func load<T: Decodable>(_ filename: String) -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
