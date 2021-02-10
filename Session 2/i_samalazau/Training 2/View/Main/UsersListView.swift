//
//  UsersListView.swift
//  Training 2
//
//  Created by Ivan Samalazau on 09/02/2021.
//

import SwiftUI

struct UsersListView: View {
    @ObservedObject var dataSource = UsersDataSource()
//    @State var isLoading = false

    var body: some View {

        Group {
            NavigationView {
//                if isLoading {
//                    ProgressView()
//                } else {
                    List(dataSource.users) { user in
                        UserRow(user: user)
                    }
                    .onAppear {
                        dataSource.loadUsers()
                    }
                    .navigationBarTitle(Text("Users"))
                }
//            }
        }
    }
}
