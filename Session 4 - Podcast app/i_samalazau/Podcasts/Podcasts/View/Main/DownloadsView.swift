//
//  DownloadsView.swift
//  Podcasts
//
//  Created by Ivan Samalazau on 15/02/2021.
//

import SwiftUI

struct DownloadsView: View {
    @EnvironmentObject var playerController: PlayerController
    @EnvironmentObject var downloadManager: DownloadManager

    private var durationFormatter: DateComponentsFormatter {
        let f = DateComponentsFormatter()
        f.unitsStyle = .abbreviated
        f.allowedUnits = [.hour, .minute]
        return f
    }

    var body: some View {
        NavigationView {
            VStack {
                List(downloadManager.items) { item in
                    DownloadRow(item: item, durationFormatter: durationFormatter)
                    //                    .onTapGesture {
                    //                        withAnimation {
                    //                            try? playerController.startPlay(item: item)
                    //                        }
                    //                    }
                        .contextMenu {
//                            guard case let ItemMetaState.ready(url) = item.state else {
//                                EmptyView()
//                                return
//                            }

                            Button {
                                guard case ItemMetaState.ready = item.state else { return }
                                try? downloadManager.remove(item)
                            } label: {
                                Label("Remove file", systemImage: "globe")
                            }
                        }
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle(Text("Downloads"))

                if playerController.state == .playing {
                    PlayerView()
                        .frame(maxWidth: .infinity)
                        .transition(.move(edge: .bottom))
                }
            }
        }
    }
}
