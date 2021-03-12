//
//  Always.swift
//  Podcasts
//
//  Created by Ivan Samalazau on 02/03/2021.
//

import Combine

/// A publisher that repeatedly sends the same value as long as there is demand.
public struct Always<Output>: Publisher {

    public typealias Failure = Never

    public let output: Output

    public init(_ output: Output) {
        self.output = output
    }

    public func receive<S: Subscriber>(subscriber: S) where S.Input == Output, S.Failure == Failure {
        let subscription = Subscription(output: output, subscriber: subscriber)
        subscriber.receive(subscription: subscription)
    }
}

private extension Always {

    final class Subscription<S: Subscriber> where S.Input == Output, S.Failure == Failure {
        private let output: Output
        private var subscriber: S?

        init(output: Output, subscriber: S) {
            self.output = output
            self.subscriber = subscriber
        }
    }
}

extension Always.Subscription: Cancellable {

    func cancel() {
        subscriber = nil
    }
}

extension Always.Subscription: Subscription {

    func request(_ demand: Subscribers.Demand) {
        var demand = demand
        while let subscriber = subscriber, demand > 0 {
            demand -= 1
            demand += subscriber.receive(output)
        }
    }
}
