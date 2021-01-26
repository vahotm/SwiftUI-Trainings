//
//  ContentView.swift
//  Training 2
//
//  Created by Ivan Samalazau on 24/01/2021.
//

import SwiftUI

struct BullshitListView: View {
    @State var showsAlert = false
    
    var body: some View {
        NavigationView {
            List(items) { item in
                BullshitRow(item: item)
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("The Bullshit List"))
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.showsAlert = true
                                    }, label: {
                                        Image(systemName: "plus")
                                    })
            )
            .alert(isPresented: $showsAlert, content: {
                Alert(title: Text("123"))
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BullshitListView()
    }
}
