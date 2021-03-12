//
//  PlayerController.swift
//  Podcasts
//
//  Created by Ivan Samalazau on 02/03/2021.
//

import Foundation
import FeedKit
import AVFoundation

enum PlayerState {
    case uninitialized
    case playing
    case paused
}

class PlayerController: ObservableObject {

    @Published var player = MyPlayer()
    @Published var state: PlayerState = .uninitialized
    @Published var playedItem: RSSFeedItem?

    func startPlay(item: RSSFeedItem) throws {
        guard let url = item.playableURL else { return }

        playedItem = item

        try AVAudioSession.sharedInstance().setCategory(.playback)
        let playerItem = AVPlayerItem(url: url)
        player.volume = 1.0
        player.replaceCurrentItem(with: playerItem)

        play()
    }

    func play() {
        player.play()
        state = .playing
    }

    func pause() {
        player.pause()
        state = .paused
    }
}
