//
//  PlayerView.swift
//  Podcasts
//
//  Created by Ivan Samalazau on 15/02/2021.
//

import SwiftUI
import FeedKit
import AVFoundation

struct PlayerView: View {

    @EnvironmentObject var playerController: PlayerController

    private var timeFormatter: DateComponentsFormatter {
        let f = DateComponentsFormatter()
        f.unitsStyle = .positional
        return f
    }

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if let item = playerController.playedItem {
                ProgressView(value: playerController.player.progress, total: item.duration, label: {
                    Text(playerController.playedItem?.title ?? "")
                        .lineLimit(1)
                }, currentValueLabel: {
                    HStack {
                        Text(timeFormatter.string(from: playerController.player.progress) ?? "")
                        Spacer()
                        Text(timeFormatter.string(from: item.duration) ?? "")
                    }
                })
                .padding()
            }
            HStack {
                Button {
                    if playerController.state == .playing {
                        playerController.pause()
                    } else {
                        playerController.play()
                    }
                } label: {
                    switch playerController.state {
                    case .playing:
                        Image(systemName: "pause")
                    case .paused:
                        Image(systemName: "play")
                    default:
                        Image(systemName: "play")
                    }
                }
                .frame(width: 30, height: 30)
            }
            .padding()
        }
        .background(Color.yellow)
    }
}
