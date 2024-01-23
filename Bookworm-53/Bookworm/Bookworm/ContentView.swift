//
//  ContentView.swift
//  Bookworm
//
//  Created by Fernando Fontanive on 20/01/24.
//
//  Modify ContentView so that books rated as 1 star are highlighted somehow, such as having their name shown in red.

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book]
    
    @State private var isShowingAddBookView = false
    
//    let isOneStarBook = books.rating > 1 ? true : false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .foregroundStyle((book.rating > 1) ? .red : .primary)
                                    .font(.headline)
                                    
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)}
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        isShowingAddBookView.toggle()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $isShowingAddBookView) {
                AddBookView()
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
        //find
            let book = books[offset]
                            
            
            //delete
                             modelContext.delete(book)
            
        }
    }
}

#Preview {
    ContentView()
}
