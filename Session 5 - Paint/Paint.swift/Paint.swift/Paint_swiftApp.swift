//
//  Paint_swiftApp.swift
//  Paint.swift
//
//  Created by Ivan Samalazau on 06/04/2021.
//

import SwiftUI

@main
struct Paint_swiftApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DrawingController())
        }
    }
}
