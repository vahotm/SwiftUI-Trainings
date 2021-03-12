//
//  DownloadsView.swift
//  Podcasts
//
//  Created by Ivan Samalazau on 15/02/2021.
//

import SwiftUI

struct DownloadsView: View {
    @EnvironmentObject var playerController: PlayerController


    var body: some View {
        VStack {
            Text("Downloads")
                .padding()
            
            if playerController.state == .playing {
                PlayerView()
                    .frame(maxWidth: .infinity)
                    .transition(.move(edge: .bottom))
            }
        }
    }
}
