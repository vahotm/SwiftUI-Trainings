//
//  UsersDataSource.swift
//  Training 2
//
//  Created by Ivan Samalazau on 09/02/2021.
//

import Foundation
import SwiftUI
import Combine

class UsersDataSource: ObservableObject {

    @Published var users: [User]
    var urlSession = URLSession.shared

    let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
    var cancellable: AnyCancellable?

    init() {
        users = []
    }

    func loadUsers() {
        cancellable = urlSession
            .dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: [User].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                print ("Received completion: \($0).")
            }, receiveValue: { [weak self] users in
                self?.users = users
            })
    }

}
