//
//  ContentView.swift
//  BucketList
//
//  Created by Fernando Fontanive on 04/02/24.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()

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
