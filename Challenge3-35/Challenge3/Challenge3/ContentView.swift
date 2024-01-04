//
//  ContentView.swift
//  Challenge3
//
//  Created by Fernando Fontanive on 04/01/24.
//
/* Start with an App template, then add some state to determine whether the game is active or whether you’re asking for settings.
Generate a range of questions based on the user’s settings.
Show the player how many questions they got correct at the end of the game, then offer to let them play again. */


import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
