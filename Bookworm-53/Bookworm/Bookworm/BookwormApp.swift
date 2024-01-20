//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Fernando Fontanive on 20/01/24.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
