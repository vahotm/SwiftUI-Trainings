//
//  PlayerExtensions.swift
//  Podcasts
//
//  Created by Ivan Samalazau on 02/03/2021.
//

import AVFoundation
import Combine

class MyPlayer: AVPlayer, ObservableObject {

    @Published private(set) var progress: TimeInterval = 0
    @Published private(set) var isBuffering: Bool = false

    private var timeObserver: Any?
    private var statusObservation: NSKeyValueObservation?

    override init() {
        super.init()

        statusObservation = observe(\.timeControlStatus, options: [.new], changeHandler: { [weak self] _, change in
            guard let self = self else { return }
            self.isBuffering = self.timeControlStatus == .waitingToPlayAtSpecifiedRate
        })
    }

    override func play() {
        super.play()

        // Notify every half second
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)

        timeObserver = addPeriodicTimeObserver(forInterval: time, queue: .main) { [weak self] time in
            self?.progress = CMTimeGetSeconds(time)
        }
    }

    override func pause() {
        super.pause()
        removeObservers()
    }

    deinit {
        removeObservers()
    }

    private func removeObservers() {
        if let observer = timeObserver {
            removeTimeObserver(observer)
        }
    }
}

extension AVPlayer {

    var isPlaying: Bool {
        currentItem != nil && rate > 0
    }

    var duration: TimeInterval {
        guard let duration = currentItem?.duration else { return .zero }
        return CMTimeGetSeconds(duration)
    }

    func seek(to position: Double, completion: (() -> Void)? = nil) {
        guard let item = currentItem, 0...1 ~= position else { return }
        let desiredSeconds = CMTimeGetSeconds(item.duration) * position
        seek(to: CMTime(seconds: desiredSeconds, preferredTimescale: CMTimeScale(NSEC_PER_SEC))) { _ in
            completion?()
        }
    }
}
