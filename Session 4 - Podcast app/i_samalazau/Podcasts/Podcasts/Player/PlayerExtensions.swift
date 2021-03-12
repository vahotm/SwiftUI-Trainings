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

    private var timeObserver: Any?

    override func play() {
        super.play()

        timeObserver = addPeriodicTimeObserver(forInterval: CMTime(value: 1, timescale: 2), queue: .main, using: { [weak self] time in
            guard let self = self else { return }
            self.progress = CMTimeGetSeconds(time)
        })
    }

    override func pause() {
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
}
