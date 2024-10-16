//
//  ContentView.swift
//  Flashzilla
//
//  Created by Fernando Fontanive on 16/10/24.
//

import SwiftUI

struct ContentView: View {
    //    @State private var currentAmount = 0.0
    //    @State private var finalAmount = 1.0
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    
    @State private var currentAmount = Angle.zero
    @State private var finalAmount = Angle.zero
    
    var body: some View {
        VStack {
            let dragGesture = DragGesture()
                .onChanged { value in
                    offset = value.translation
                }
                .onEnded{_ in
                    withAnimation {
                        offset = .zero
                        isDragging = false
                    }
                    
                }
                
            
            let pressGesture = LongPressGesture()
                .onEnded { value in
                    withAnimation {
                        isDragging = true
                        
                    }
                }
                
            let combined = pressGesture.sequenced(before: dragGesture)
                            
            Circle()
                .fill(.red)
                .frame(width: 64, height: 64)
                .scaleEffect(isDragging ? 1.5 : 1)
                .offset(offset)
                .gesture(combined)
                    
                
        }
    }
    
}


#Preview {
    ContentView()
}
//                .simultaneousGesture(
////                .highPriorityGesture(
//                    TapGesture()
//                        .onEnded{
//                            print("high priority tapped")
//                .rotationEffect(currentAmount + finalAmount)
//                .gesture(
//                    RotateGesture()
//                        .onChanged { value in
//                            currentAmount = value.rotation
//                        }
//                        .onEnded { value in
//                            finalAmount += currentAmount
//                            currentAmount = .zero
//                        }
//                )
//                .scaleEffect(finalAmount + currentAmount)
//                    MagnifyGesture()
//                    .onChanged { value in
//                        currentAmount = value.magnification - 1
//                    }
//                    .onEnded { value in
//                        finalAmount += currentAmount
//                        currentAmount =  0
//                    }
//
//                .onTapGesture(count: 2) {
//                    print("Double Tapped")
//                }
//                .onLongPressGesture(minimumDuration: 2) {
//                    print("Long Pressed")
//                } onPressingChanged: { inProgress in
//                    print("In Progress: \(inProgress)")
//                }
