//
//  DetailView.swift
//  Bookworm
//
//  Created by Fernando Fontanive on 22/01/24.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    let book: Book
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre.uppercased())
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
        }
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)
            
            Text(book.review)
                .padding()
            
            //Text("Added on \(book.date)") funciona
            // tip from https://www.hackingwithswift.com/forums/100-days-of-swiftui/bookworm-challenge-3/25056
            
            Text("Added on \(Date.now, format: .dateTime.day().month().year())")
            
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
        }
        .toolbar {
            Button("Delete this book", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        }
    
    
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Test Title", author: "Test Author", genre: "Fantasy", review: "This is a noice book, perfect, greates book ever", rating: 1, date: Date())
        
        return DetailView(book: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview \(error.localizedDescription)")
    }
}
