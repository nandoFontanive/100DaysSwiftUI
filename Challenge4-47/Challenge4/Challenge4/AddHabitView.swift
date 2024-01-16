//
//  AddHabitView.swift
//  Challenge4
//
//  Created by Fernando Fontanive on 15/01/24.
//

import SwiftUI

struct AddHabitView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = "habito"
    @State private var type = "Personal"
    
    //    @State private var titulo = "titulo"
    
    var habits: Habits
    
    let types = ["Business", "Personal"]
    
    
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar() {
                ToolbarItem(placement: .topBarTrailing) {
                    
                    
                    Button("Save") {
                        let item = HabitItem(name: name, type: type)
                        habits.items.append(item)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
            }
        }
        
        .navigationBarBackButtonHidden()
        
        
    }
}
