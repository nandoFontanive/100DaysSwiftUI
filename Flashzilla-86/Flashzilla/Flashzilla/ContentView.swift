//
//  ContentView.swift
//  Flashzilla
//
//  Created by Fernando Fontanive on 16/10/24.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @State private var cards = Array<Card>(repeating: .example, count: 10)
    
    @State private var showingEditScreen = false
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Text("Timer: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: cards[index]) {
                            withAnimation {
                                removeCard(at: index)
                            }
                        }
                        .stacked(at: index, in: cards.count)
                        .allowsHitTesting(index == cards.count - 1)
                        .accessibilityHidden(index < cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
                    Button("Start again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                }
                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
            
            if accessibilityDifferentiateWithoutColor || accessibilityVoiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1)
                            }
                        } label: {
                            
                            
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as incorrect.")
                        Spacer()
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as correct.")
                    }
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                if cards.isEmpty {
                    isActive = true
                }
            }
            else {
                isActive = false
            }
        }
    }
    func removeCard(at index: Int) {
        guard index >= 0 else { return }
        cards.remove(at: index)
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        cards = Array<Card>(repeating: .example, count: 10)
        timeRemaining = 100
        isActive = true
    }
}




#Preview {
    ContentView()
}




//struct ContentView: View {
//    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
//
//    var body: some View {
//        Text("Hello, World!")
//            .padding()
//            .background(reduceTransparency ? .black : .black.opacity(0.5))
//            .foregroundStyle(.white)
//            .clipShape(.capsule)
//    }
//}

//struct ContentView: View {
//    @Environment(\.accessibilityReduceMotion) var reduceMotion
//    @State private var scale = 1.0
//
//    var body: some View {
//        Button("Hello, World!") {
//            if reduceMotion {
//                scale *= 1.5
//            } else {
//                withAnimation {
//                    scale *= 1.5
//                }
//            }
//
//        }
//        .scaleEffect(scale)
//    }
//}



//struct ContentView: View {
//    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
//
//    var body: some View {
//        HStack {
//            if differentiateWithoutColor {
//                Image(systemName: "checkmark.circle")
//            }
//
//            Text("Success")
//        }
//        .padding()
//        .background(differentiateWithoutColor ? .black : .green)
//        .foregroundStyle(.white)
//        .clipShape(.capsule)
//    }
//}







//struct ContentView: View {
//    @Environment(\.scenePhase) var scenePhase
//
//    var body: some View {
//        Text("Hello, world!")
//            .onChange(of: scenePhase) { oldPhase, newPhase in
//                if newPhase == .active {
//                    print("Active")
//                } else if newPhase == .inactive {
//                    print("Inactive")
//                } else if newPhase == .background {
//                    print("Background")
//                }
//            }
//    }
//}


//struct ContentView: View {
//    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
//
//    var body: some View {
//        HStack {
//            if differentiateWithoutColor {
//                Image(systemName: "checkmark.circle")
//            }
//
//            Text("Success")
//        }
//        .padding()
//        .background(differentiateWithoutColor ? .black : .green)
//        .foregroundStyle(.white)
//        .clipShape(.capsule)
//    }
//}


//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//
//    var body: some View {
//
//            Text("Hello")
//            .onReceive(timer) { time in
//                if count == 5 {
//                    timer.upstream.connect().cancel()
//
//                }
//                else {
//                    print("The time is now: \(time)")
//
//                    count += 1
//                }
//            }
//    }
//
//    func cancelTimer() {
//        timer.upstream.connect().cancel()
//    }
//    @State private var currentAmount = 0.0
//    @State private var finalAmount = 1.0
//    @State private var offset = CGSize.zero
//    @State private var isDragging = false
//    @State private var currentAmount = Angle.zero
//    @State private var finalAmount = Angle.zero
//        VStack {
//            let dragGesture = DragGesture()
//                .onChanged { value in
//                    offset = value.translation
//                }
//                .onEnded{_ in
//                    withAnimation {
//                        offset = .zero
//                        isDragging = false
//                    }
//
//                }
//
//
//            let pressGesture = LongPressGesture()
//                .onEnded { value in
//                    withAnimation {
//                        isDragging = true
//
//                    }
//                }
//
//            let combined = pressGesture.sequenced(before: dragGesture)
//
//            Circle()
//                .fill(.red)
//                .frame(width: 64, height: 64)
//                .scaleEffect(isDragging ? 1.5 : 1)
//                .offset(offset)
//                .gesture(combined)
//
//
//        }
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
