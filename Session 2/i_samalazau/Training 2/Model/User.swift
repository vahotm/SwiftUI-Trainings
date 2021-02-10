//
//  User.swift
//  Training 2
//
//  Created by Ivan Samalazau on 09/02/2021.
//

import Foundation

/**
     "id": 1,
     "name": "Leanne Graham",
     "username": "Bret",
     "email": "Sincere@april.biz",
     "address": {
       "street": "Kulas Light",
       "suite": "Apt. 556",
       "city": "Gwenborough",
       "zipcode": "92998-3874",
       "geo": {
         "lat": "-37.3159",
         "lng": "81.1496"
       }
     },
     "phone": "1-770-736-8031 x56442",
     "website": "hildegard.org",
     "company": {
       "name": "Romaguera-Crona",
       "catchPhrase": "Multi-layered client-server neural-net",
       "bs": "harness real-time e-markets"
     }
 */
struct User: Hashable, Codable, Identifiable {
    let id: Int
    let name: String
    let email: String

    var imageUrl: URL {
        User.imageUrl(id: id)
    }

    private static func imageUrl(id: Int) -> URL {
        URL(string: "https://loremflickr.com/640/480/girl?lock=\(id)")!
    }
}
