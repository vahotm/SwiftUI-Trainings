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
    @State private var progress = 0.0

    private let paddedTimeFormatter: DateComponentsFormatter = {
        let f = DateComponentsFormatter()
        f.unitsStyle = .positional
        f.zeroFormattingBehavior = .pad
        return f
    }()

    private let timeFormatter: DateComponentsFormatter = {
        let f = DateComponentsFormatter()
        f.unitsStyle = .positional
        return f
    }()

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if let item = playerController.playedItem {

                    ProgressView(value: progress, total: item.duration, label: {
                        Text(playerController.playedItem?.title ?? "")
                            .lineLimit(1)
                    }, currentValueLabel: {
                        HStack {
                            if playerController.player.isBuffering {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                            } else {
                                Text(paddedTimeFormatter.string(from: playerController.player.progress) ?? "")
                            }
                            Spacer()
                            Text(timeFormatter.string(from: item.duration) ?? "")
                        }
                    })
                    .padding([.top, .leading, .trailing])
                    .onReceive(playerController.player.$progress) { newProgress in
                        progress = newProgress
                    }
                    .onReceive(playerController.$playedItem) { item in
                        guard let item = item else { return }
                        paddedTimeFormatter.allowedUnits = allowedUnits(for: item.duration)
                    }
                    .gesture(
                        DragGesture(minimumDistance: 1, coordinateSpace: .local)
                            .onChanged { value in
                                print("\(value.location.x)")
                                //                                    self.playerController.player.seek(to: )
                            }
                    )
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
                .frame(width: 24, height: 24)
            }
            .padding(.bottom)
        }
        .background(Color.yellow)
//        .gesture(
//            DragGesture(minimumDistance: 1, coordinateSpace: .local)
//                .onChanged { value in
//                    print("\(value.location.x)")
//                    //                                    self.playerController.player.seek(to: )
//                }
//        )
    }

    private func allowedUnits(for duration: TimeInterval) -> NSCalendar.Unit {
        if duration > 3600 {
            return [.hour, .minute, .second]
        } else {
            return [.minute, .second]
        }
    }
}
