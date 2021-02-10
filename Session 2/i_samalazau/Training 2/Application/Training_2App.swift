//
//  Training_2App.swift
//  Training 2
//
//  Created by Ivan Samalazau on 24/01/2021.
//

import SwiftUI

@main
struct Training_2App: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                BullshitListView()
                UsersListView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Users")
                    }
            }
        }
    }
}
