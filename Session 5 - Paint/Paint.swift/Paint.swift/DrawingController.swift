//
//  DrawingController.swift
//  Paint.swift
//
//  Created by Ivan Samalazau on 06/04/2021.
//

import Foundation
import UIKit

class DrawingController: ObservableObject {

    @Published private(set) var path: CGPath?

    @Published private(set) var points: [CGPoint] = [] {
        didSet {
            path = path(from: points)
        }
    }

    var floatingPoint: CGPoint? {
        didSet {
            if let point = floatingPoint {
                path = path(from: points.appending(point))
            } else {
                path = path(from: points)
            }
        }
    }

    func add(point: CGPoint) {
        points.append(point)
    }

    private func path(from points: [CGPoint]) -> CGPath? {
        guard let first = points.first else { return nil }
        let path = CGMutablePath()
        path.move(to: first)
        points.dropFirst().forEach { path.addLine(to: $0) }
        return path
    }
}

extension Array {

    func appending(_ element: Element) -> Array {
        var newArray = self
        newArray.append(element)
        return newArray
    }
}
