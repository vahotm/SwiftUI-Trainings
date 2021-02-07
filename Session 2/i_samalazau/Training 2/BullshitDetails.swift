//
//  BullshitDetails.swift
//  Training 2
//
//  Created by Ivan Samalazau on 24/01/2021.
//

import SwiftUI

struct BullshitDetails: View {
    @Binding var item: BullshitItem
    @State var countInternal: Int

    init(item: Binding<BullshitItem>) {
        _item = item
        _countInternal = State(wrappedValue: item.wrappedValue.count)
    }

    var body: some View {
        NavigationView {
            VStack {
                LoadableImage(url: item.imageUrl)
                    .aspectRatio(contentMode: .fit)
                    .background(Color.gray)

                HStack {
                    Stepper("Count: \(countInternal)", value: $countInternal, step: 1, onEditingChanged: { (isPressed) in
                        if !isPressed {
                            item.count = countInternal
                        }
                    })
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
