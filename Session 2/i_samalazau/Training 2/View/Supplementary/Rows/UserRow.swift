//
//  UserRow.swift
//  Training 2
//
//  Created by Ivan Samalazau on 09/02/2021.
//

import SwiftUI

struct UserRow: View {
    var user: User

    var body: some View {
            VStack(spacing: 10) {
                LoadableImage(url: user.imageUrl, placeholder: UIImage(systemName: "photo")!)
                    .aspectRatio(contentMode: .fit)
                Text(user.name)
                    .font(.headline)
            }
    }
}
