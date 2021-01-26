//
//  BullshitDetails.swift
//  Training 2
//
//  Created by Ivan Samalazau on 24/01/2021.
//

import SwiftUI

struct BullshitDetails: View {
    @Binding var item: BullshitItem

    var body: some View {
        NavigationView {
            VStack {
                LoadableImage(url: item.imageUrl)
                    .aspectRatio(contentMode: .fit)
                    .background(Color.gray)

                HStack {
//                    Text("Count")
//                        .font(.headline)
//                    Spacer()
//                    Text(item.count)
//                        .font(.body)
                    Stepper(value: $item.count, in: 0...100, label: {
                        HStack {
                            Text("Count")
                                .font(.headline)
                            Spacer()
                            Text("\(item.count)")
                                .font(.body)
                        }
                    })
//                    Stepper("Count", value: $item.count, in: 0...100)
                        .padding()
                }
            }
            .navigationBarTitle(Text(item.title))
        }
    }
}

//struct BullshitDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        BullshitDetails(item: DataSource().items[0])
//    }
//}
