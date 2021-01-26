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

    var id: String { title }
}
