//
//  ContentView.swift
//  Paint.swift
//
//  Created by Ivan Samalazau on 06/04/2021.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var drawingController: DrawingController
    @State var showHint = true

    let style = StrokeStyle(lineWidth: 3.0, lineCap: .round, lineJoin: .round)

    var body: some View {
        let tap = TapGesture(count: 1)

        let drag = DragGesture(minimumDistance: 0).onChanged { value in
            drawingController.floatingPoint = value.location
        }
        .onEnded { value in
            drawingController.floatingPoint = nil
            drawingController.add(point: value.location)
            showHint = drawingController.points.isEmpty
        }
        .sequenced(before: tap)

        NavigationView {
            ZStack {
                Color("background")
                    .edgesIgnoringSafeArea(.all)
                    .gesture(drag)

                if let path = drawingController.path {
                    Path(path)
                        .stroke(style: style)
                }

                if showHint {
                    Text("Draw a line here")
                        .font(.body)
                        .foregroundColor(.primary)
                }
            }
            .navigationBarTitle(Text("Paint"))
        }
    }
}

