//
//  LoadableImage.swift
//  Training 2
//
//  Created by Ivan Samalazau on 24/01/2021.
//

import SwiftUI

struct LoadableImage: View {

    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()

    init(url: URL) {
        imageLoader = ImageLoader(url: url)
    }

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .onReceive(imageLoader.subject) { image in
                self.image = image
            }
    }
}
