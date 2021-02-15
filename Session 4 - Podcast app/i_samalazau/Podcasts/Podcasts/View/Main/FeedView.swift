//
//  FeedView.swift
//  Podcasts
//
//  Created by Ivan Samalazau on 15/02/2021.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var feedDataSource = FeedDataSource(url: "https://oper.ru/video.xml")!
    
    var body: some View {
        NavigationView {
            List(feedDataSource.items) { item in
                Text(item.title ?? "")
            }
            .navigationBarTitle(Text(feedDataSource.feed?.title ?? ""))
            .onAppear(perform: feedDataSource.fetchFeed)
        }
    }
}
