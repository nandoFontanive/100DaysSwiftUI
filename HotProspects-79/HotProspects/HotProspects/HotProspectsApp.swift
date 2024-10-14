//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Fernando Fontanive on 11/10/24.
//

import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
