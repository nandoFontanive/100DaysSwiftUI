//
//  ContentView.swift
//  iExpense
//
//  Created by Fernando Fontanive on 07/01/2024.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    var personalItems: [ExpenseItem] {
        items.filter { $0.type == "Personal"}
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}
//Change project 7 (iExpense) so that it uses NavigationLink for adding new expenses rather than a sheet. (Tip: The dismiss() code works great here, but you might want to add the navigationBarBackButtonHidden() modifier so they have to explicitly choose Cancel.)

struct ContentView: View {
    @State private var expenses = Expenses()
    
//    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            NavigationLink("Add Expense") {
                AddView(expenses: expenses)
            }
            List {
                Section {
                    ForEach(expenses.items) { item in
                        if item.type == "Personal" {
                            HStack {
                                //                                VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                //                                }
                                Spacer()
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "BRL"))
                                    .foregroundColor(item.amount > 100 ? .red : ((item.amount) > 10 ? .blue : .black))
                            }
                            //Modify the expense amounts in ContentView to contain some styling depending on their value – expenses under $10 should have one style, expenses under $100 another, and expenses over $100 a third style.
                        }
                    }
                    .onDelete(perform: removeItems)
                } header: {
                    Text("Personal expenses")
                }
                Section {
                    ForEach(expenses.items) { item in
                        if item.type == "Business" {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                }
                                Spacer()
                                Text(item.amount, format: .currency(code: "BRL"))
                                    .foregroundColor(item.amount > 100 ? .red : ((item.amount) > 10 ? .blue : .black))
                            }
                            //Modify the expense amounts in ContentView to contain some styling depending on their value – expenses under $10 should have one style, expenses under $100 another, and expenses over $100 a third style.
                        }
                    }
                    .onDelete(perform: removeItems)
                } header: {
                    Text("Business expenses") }
            }
            .navigationTitle("iExpense")
//            .toolbar {
//                Button("Add Expense", systemImage: "plus") {
//                    showingAddExpense = true
//                }
//            }
//            .sheet(isPresented: $showingAddExpense) {
//                AddView(expenses: expenses)
//            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}



#Preview {
    ContentView()
}
