//
//  ContentView.swift
//  Challenge4
//
//  Created by Fernando Fontanive on 15/01/24.
/* - App that list of all activities they want to track, plus a form to add new activities – a title and description should be enough.
   - For a bigger challenge, tapping one of the activities should show a detail screen with the description. For a tough challenge – see the hints below! – make that detail screen contain how many times they have completed it, plus a button incrementing their completion count.
   - And if you want to make the app really useful, use Codable and UserDefaults to load and save all your data.
 */
 

import SwiftUI

struct HabitItem: Hashable {
    var name = ""
    var timesPerWeek = 0
    var timesExecuted = 0
}

struct ContentView: View {
    
    @State private var registeredHabits = [String]()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Current habits")
                List {
                    ForEach() { habits in
                        registeredHabits[$0]
                    }
                }
            }
            .navigationTitle("Habits app")
        }
        .toolbar {
            Button("Add habit") {
                HabitView()
    }
            }
        }
}

#Preview {
    ContentView()
}
