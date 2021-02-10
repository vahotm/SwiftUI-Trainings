//
//  ImageLoader.swift
//  Training 2
//
//  Created by Ivan Samalazau on 24/01/2021.
//

import Foundation
import Combine
import UIKit

class ImageLoader: ObservableObject {

    var subject = PassthroughSubject<UIImage, Never>()
    var image = UIImage() {
        didSet {
            subject.send(image)
        }
    }
    var placeholderImage = UIImage(systemName: "photo")

    init(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else if let placeholder = self.placeholderImage {
                DispatchQueue.main.async {
                    self.image = placeholder
                }
            }
        }
        task.resume()
    }
}
