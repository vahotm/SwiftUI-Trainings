//
//  LoadableImage.swift
//  Training 2
//
//  Created by Ivan Samalazau on 24/01/2021.
//

import SwiftUI

struct LoadableImage: View {

    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage

    init(url: URL, placeholder: UIImage = UIImage()) {
        imageLoader = ImageLoader(url: url)
        _image = State(wrappedValue:placeholder)
    }

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .onReceive(imageLoader.subject) { image in
                self.image = image
            }
    }
}
