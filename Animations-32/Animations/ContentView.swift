//
//  ContentView.swift
//  Animations
//
//  Created by Fernando Fontanive on 29/12/23.
//

import SwiftUI

struct ContentView: View {
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count, id: \.self) { num in
                Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(enabled ? .blue : .red)
                    .offset(dragAmount)
                    .animation(.linear.delay(Double(num) / 20), value: dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation }
                .onEnded { _ in
                    dragAmount = .zero
                    enabled.toggle()
                }
        )
    }



//struct ContentView: View {
////    @State private var animationAmount = 1.0
//    @State private var animationAmount = 0.0
//    
//    var body: some View {
//        
//        VStack {
//            Button("Tap Me") {
//                withAnimation(.spring(duration: 1, bounce: 0.5)) {
//                    animationAmount += 360
//                }
//            }
//            .padding(50)
//            .background(.red)
//            .foregroundColor(.white)
//            .clipShape(.circle)
//            .rotation3DEffect(
//                .degrees(animationAmount), axis: (x: 0, y: 1, z: 0)
//            )
//        }
//    }
        
//        VStack {
//            Button("Tap Me") {
//
//
//            }
//            .padding(50)
//            .background(.red)
//            .foregroundStyle(.white)
//            .clipShape(.circle)
//            .overlay(
//                Circle()
//                    .stroke(.red)
//                    .scaleEffect(animationAmount)
//                    .opacity(2 - animationAmount)
//                    .animation(
//                        .easeInOut(duration: 1)
//                            .repeatForever(autoreverses: false),
//                        value: animationAmount
//                    )
//            )
//            .onAppear {
//                animationAmount = 2
//            }
//
//
//        }
//        .padding(50)

    }


#Preview {
    ContentView()
}
