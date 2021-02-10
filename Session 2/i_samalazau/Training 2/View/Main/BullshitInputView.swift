//
//  BullshitInputView.swift
//  Training 2
//
//  Created by Ivan Samalazau on 26/01/2021.
//

import SwiftUI

struct BullshitInputView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var inputStringInternal: String = ""

    let onDismiss: (String) -> Void

    var body: some View {

        NavigationView {
            VStack {
                TextField(
                    "Bullshit name",
                    text: $inputStringInternal
                )
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                Spacer()
            }
            .navigationBarTitle(Text("The Bullshit List"))
            .navigationBarItems(
                leading: Button("Cancel", action: {
                    presentationMode.wrappedValue.dismiss()
                }),
                trailing: Button("Done", action: {
                    onDismiss(inputStringInternal)
                    presentationMode.wrappedValue.dismiss()
                })
            )
        }
    }
}
