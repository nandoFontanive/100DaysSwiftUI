//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Fernando Fontanive on 23/01/24.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
