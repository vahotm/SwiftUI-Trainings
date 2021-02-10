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
    @State var sortAscending = false
    @State var searchText = ""

    func filter(_ item: BullshitItem) -> Bool {
        searchText.isEmpty ? true : item.title.lowercased().contains(searchText.lowercased())
    }
    
    var body: some View {
            NavigationView {
                VStack {
                    SearchBar(text: $searchText)
                    List(dataSource.items.filter(filter(_:))) { item in
                        NavigationLink(destination: BullshitDetails(item: $dataSource.items[dataSource.index(of: item)])) {
                            BullshitRow(item: item)
                                .contextMenu {
                                    Button("Delete") {
                                        dataSource.items.removeAll { (searchItem) -> Bool in
                                            searchItem == item
                                        }
                                    }
                                }
                        }
                    }
                    .listStyle(GroupedListStyle())

                }
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
            .tabItem {
                Image(systemName: "trash")
                Text("Bullshit")
        }
    }
}

struct BullshitListView_Previews: PreviewProvider {
    static var previews: some View {
        BullshitListView()
    }
}
