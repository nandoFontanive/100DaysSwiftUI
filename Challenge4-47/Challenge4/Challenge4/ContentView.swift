//
//  ContentView.swift
//  Challenge4
//
//  Created by Fernando Fontanive on 15/01/24.
/* - App that list of all activities they want to track, plus a form to add new activities – a title and description should be enough.
 - For a bigger challenge, tapping one of the activities should show a detail screen with the description. For a tough challenge – see the hints below! – make that detail screen contain how many times they have completed it, plus a button incrementing their completion count.
 - And if you want to make the app really useful, use Codable and UserDefaults to load and save all your data.
 


import SwiftUI

struct HabitItem: Identifiable, Hashable, Codable {
    var id = UUID()
    let name: String
    let timesPerWeek: Int
    let timesExecuted: Int
}

@Observable
class Habits {
    var items = [HabitItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    var personalHabits: [HabitItem] {
        items.filter { $0.type == "Personal"}
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([HabitItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

struct ContentView: View {
    @State private var registeredHabits = Habits()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(registeredHabits.items) { item in
                        if item.type == "Personal" {
                            HStack {
                                Text(item.name)
                                Spacer()
                                Text(item.timesPerWeek)
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                } header: {
                    Text("Personal expenses")
                }
                
            }
            
            
            .navigationTitle("Habits app")
            .toolbar {
                Button("Add habit") {
//                    HabitView(habits: registeredHabits)
                    HabitView()
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        registeredHabits.remove(atOffsets: offsets)
    }
}

//
//#Preview {
//    ContentView()
//}
*/

//
//  ContentView.swift
//  iExpense
//
//  Created by Fernando Fontanive on 07/01/2024.
//

import SwiftUI

struct HabitItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
}

@Observable
class Habits {
    var items = [HabitItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    var activityHabit: [HabitItem] {
        items.filter { $0.type == "Activity"}
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([HabitItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

struct ContentView: View {
    @State private var registeredHabits = Habits()


    
    var body: some View {
        NavigationStack {

            
            List {
                Section {
                    ForEach(registeredHabits.items) { item in
                        if item.type == "Activity" {
                            HStack {
                                
                                Text(item.name)
                                    .font(.headline)
                                
                                Spacer()
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                } header: {
                    Text("Activities")
                }
            }
            .navigationTitle("Habit tracking app")
            .toolbar() {
                ToolbarItem(placement: .topBarTrailing) {
                    
                        NavigationLink("Add Habit") {
                            AddHabitView(habits: registeredHabits)
                        }
                    
                }
            }
            .navigationBarBackButtonHidden()
//            .sheet(isPresented: $showingAddExpense) {
//                AddView(expenses: expenses)
//            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        registeredHabits.items.remove(atOffsets: offsets)
    }
}



#Preview {
    ContentView()
}

