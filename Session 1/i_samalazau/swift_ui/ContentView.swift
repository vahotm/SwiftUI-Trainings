//
//  ContentView.swift
//  swift_ui
//
//  Created by Ivan Samalazau on 25/10/19.
//  Copyright © 2019 Ivan Samalazau. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {

            NavigationLink(destination: OpaDetailView(title: "Опа")) {
                Text("Опа")
                    .font(.headline)
            }
            .frame(width: 80, height: 80)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(40, antialiased: true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

