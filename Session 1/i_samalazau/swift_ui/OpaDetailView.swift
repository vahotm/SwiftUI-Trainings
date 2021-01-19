//
//  OpaDetailView.swift
//  swift_ui
//
//  Created by Ivan Samalazau on 19/01/2021.
//  Copyright © 2021 Ivan Samalazau. All rights reserved.
//

import SwiftUI

struct OpaDetailView: View {

    var title: String

    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                Color.purple
                    .ignoresSafeArea()
                Image("out1")
                    .frame(width: 40, height: 40)
            }
        }
        .navigationBarTitle(Text(title))
    }
}
