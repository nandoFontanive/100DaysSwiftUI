//
//  AddView.swift
//  iExpense
//
//  Created by Fernando Fontanive on 08/01/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss

    @State private var name = "despesa"
    @State private var type = "Personal"
    @State private var amount = 0.0

//    @State private var titulo = "titulo"
    
    var expenses: Expenses

    let types = ["Business", "Personal"]

    
    
    var body: some View {
        NavigationStack {
            Form {
//                Try changing project 7 so that it lets users edit their issue name in the navigation title rather than a separate textfield. Which option do you prefer?

//                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                //Use the user’s preferred currency, rather than always using US dollars.

                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "BRL"))
//                TextField("Amount", value: $amount, format: .currency(code: "USD")) -> valor não aparece, bug?
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar() {
                ToolbarItem() {
                    
                    
                    Button("Save") {
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        expenses.items.append(item)
                        dismiss()
                    }
                    Button("Cancel") {
                        dismiss()
                    }
                    
                    
                }
            }
        }
        .navigationBarBackButtonHidden()

            
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
