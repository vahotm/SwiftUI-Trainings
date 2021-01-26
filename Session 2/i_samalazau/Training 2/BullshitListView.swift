//
//  BullshitListView.swift
//  Training 2
//
//  Created by Ivan Samalazau on 24/01/2021.
//

import SwiftUI

struct BullshitListView: View {
    @State var showsInput = false
    @ObservedObject var dataSource = DataSource()
    
    var body: some View {
        NavigationView {
            List(dataSource.items) { item in
                NavigationLink(destination: BullshitDetails(item: $dataSource.items[0])) {
                    BullshitRow(item: item)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("The Bullshit List"))
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.showsInput = true
                                    }, label: {
                                        Image(systemName: "plus")
                                    })
                                    .sheet(isPresented: $showsInput) {
                                        BullshitInputView(onDismiss: { text in
                                            guard let url = URL(string: "https://loremflickr.com/320/240/cat") else { return }
                                            dataSource.items.append(BullshitItem(title: text, count: 0, imageUrl: url))
                                        })
                                    }
            )
        }
    }
}

struct BullshitListView_Previews: PreviewProvider {
    static var previews: some View {
        BullshitListView()
    }
}
