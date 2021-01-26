//
//  BullshitRow.swift
//  Training 2
//
//  Created by Ivan Samalazau on 24/01/2021.
//

import SwiftUI

struct BullshitRow: View {
    var item: BullshitItem

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            LoadableImage(url: item.imageUrl)
                .frame(width: 40, height: 40)
                .background(Color.gray)
            Text(item.title)
                .font(.headline)
            Spacer()
            Text("\(item.count)")
                .font(.subheadline)
        }
    }
}

struct BullshitRow_Previews: PreviewProvider {
    static var dataSource = DataSource()
    static var previews: some View {
        Group {
            BullshitRow(item: dataSource.items[0])
                .previewLayout(.fixed(width: 300, height: 50))
            BullshitRow(item: dataSource.items[1])
                .previewLayout(.fixed(width: 300, height: 50))
        }
    }
}
