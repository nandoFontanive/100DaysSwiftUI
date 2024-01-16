//
//  AddHabitView.swift
//  Challenge4
//
//  Created by Fernando Fontanive on 15/01/24.
//

import SwiftUI

struct AddHabitView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Diário"
    
    //    @State private var titulo = "titulo"
    
    var habits: Habits
    
    let types = ["Diário", "Semanal"]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Nome do novo hábito", text: $name)
                Picker("Tipo do hábito", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

            }
            .navigationTitle("Adicionar novo hábito")
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
