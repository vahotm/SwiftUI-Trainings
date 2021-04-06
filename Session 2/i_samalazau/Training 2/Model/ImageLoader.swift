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
    static let placeholderImage = UIImage(systemName: "photo")

    init(url: URL) {        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else if let placeholder = Self.placeholderImage {
                DispatchQueue.main.async {
                    self.image = placeholder
                }
            }
        }
        task.resume()
    }

    func heuristicallyDetectError(_ message: String?) -> NSError? {
        let pattern = #"Domain=(\w+) Code=(-?\d+)"#
        guard let message = message, let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return nil }

        let nsrange = NSRange(message.startIndex..<message.endIndex, in: message)
        guard let match = regex.firstMatch(in: message, options: [], range: nsrange), match.numberOfRanges == 3,
              let domainRange = Range(match.range(at: 1), in: message),
              let codeRange = Range(match.range(at: 2), in: message),
              let code = Int(message[codeRange])
              else { return nil }

        let domain = String(message[domainRange])
        return NSError(domain: domain, code: code, userInfo: nil)
    }
}
