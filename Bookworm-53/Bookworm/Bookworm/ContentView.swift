//
//  ContentView.swift
//  Bookworm
//
//  Created by Fernando Fontanive on 20/01/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var books: [Book]
    @State private var isShowingAddBookView = false
    
    var body: some View {
        NavigationStack {
            Text("Count: \(books.count)")
                .navigationTitle("Bookworm")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add Book", systemImage: "plus") {
                            isShowingAddBookView.toggle()
                        }
                    }
                }
                .sheet(isPresented: $isShowingAddBookView) {
                    AddBookView()
                }
        }
    }
}

#Preview {
    ContentView()
}
