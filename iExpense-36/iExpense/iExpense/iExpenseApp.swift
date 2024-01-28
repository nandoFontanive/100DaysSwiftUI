//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Fernando Fontanive on 07/01/24.
//

import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [ExpenseItem.self])
    }
}
