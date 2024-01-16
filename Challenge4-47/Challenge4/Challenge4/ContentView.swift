//
//  ContentView.swift
//  Challenge4
//
//  Created by Fernando Fontanive on 15/01/24.
/* - App that list of all activities they want to track, plus a form to add new activities – a title and description should be enough.
 - For a bigger challenge, tapping one of the activities should show a detail screen with the description. For a tough challenge – see the hints below! – make that detail screen contain how many times they have completed it, plus a button incrementing their completion count.
 - And if you want to make the app really useful, use Codable and UserDefaults to load and save all your data.*/

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
        items.filter { $0.type == "Diário"}
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
                        if item.type == "Diário" {
                            HStack {
                                Text(item.name)
                                    .font(.headline)
                                Spacer()
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                } header: {
                    Text("Atividades diárias")
                }
                
                Section {
                    ForEach(registeredHabits.items) { item in
                        if item.type == "Semanal" {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                }
                                Spacer()
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                } header: {
                    Text("Atividades semanais") }
                
                
            }
            .navigationTitle("Habit tracking app")
            .toolbar() {
                ToolbarItem(placement: .topBarTrailing) {
                    
                        NavigationLink("Adicionar Atividade") {
                            AddHabitView(habits: registeredHabits)
                        }
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        registeredHabits.items.remove(atOffsets: offsets)
    }
}



#Preview {
    ContentView()
}
