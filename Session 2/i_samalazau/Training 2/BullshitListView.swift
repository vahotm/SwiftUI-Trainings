//
//  BullshitListView.swift
//  Training 2
//
//  Created by Ivan Samalazau on 24/01/2021.
//

import SwiftUI

struct BullshitListView: View {
    @ObservedObject var dataSource = DataSource()
    @State var showsInput = false
//    @State var selectedItem
//    @State var rowSelected = false
    @State var sortAscending = false
    
    var body: some View {
        NavigationView {
            List(dataSource.items) { item in
                NavigationLink(destination: BullshitDetails(item: $dataSource.items[0])) {
                    BullshitRow(item: item)
//                        .onTapGesture {
//                            selectedItem = item
//                            rowSelected = true
//                        }
                        .contextMenu {
                            Button("Delete") {
                                dataSource.items.removeAll { (searchItem) -> Bool in
                                    searchItem == item
                                }
                            }
                        }
                }
//                .onChange(of: selectedItem) { newValue in
//                    guard rowSelected == true else { return }
//                    guard let idx = dataSource.items.firstIndex(of: item) else { return }
//                    dataSource.items[idx] = newValue
//                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("The Bullshit List"))
            .navigationBarItems(leading:
                                    Button(action: {
                                        if sortAscending {
                                            dataSource.items.sort(by: { $0.title > $1.title })
                                        } else {
                                            dataSource.items.sort(by: { $0.title < $1.title })
                                        }
                                        sortAscending.toggle()
                                    }, label: {
                                        Image(systemName: "arrow.up.arrow.down")
                                    }),
                                trailing:
                                    Button(action: {
                                        self.showsInput = true
                                    }, label: {
                                        Image(systemName: "plus")
                                    })
                                    .sheet(isPresented: $showsInput) {
                                        BullshitInputView(onDismiss: { text in
                                            dataSource.items.append(BullshitItem(title: text))
                                        })
                                        Text("123")
                                    }
            )
        }
//        .alert(isPresented: $showsInput, TextAlert(title: "123", action: { (text) in
//            guard let url = URL(string: "https://loremflickr.com/320/240/cat"), let text = text else { return }
//            dataSource.items.append(BullshitItem(title: text, count: 0, imageUrl: url))
//        }))
    }
}

struct BullshitListView_Previews: PreviewProvider {
    static var previews: some View {
        BullshitListView()
    }
}
