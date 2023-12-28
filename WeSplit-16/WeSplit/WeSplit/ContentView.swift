//
//  ContentView.swift
//  WeSplit
//
//  Created by Fernando Fontanive on 14/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    //    let tipPercentageSuggestions = [10, 20, 25, 30, 0]
    let tipPercentageSuggestions = 0..<101
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let chosenTipPercentage = Double(tipPercentage)
        
        let tipValue = amount / 100 * chosenTipPercentage
        let finalAmountForEveryonePlusTip = amount + tipValue
        let finalAmountPerPerson = finalAmountForEveryonePlusTip / peopleCount
        
        return finalAmountPerPerson
        
    }
    
    var amountPlusTip: Double {
        let finalAmount = Double(amount)
        let selectedTipPercentage = Double(tipPercentage)
        let finalAmountPlusTip = finalAmount * (1 + (selectedTipPercentage / 100))
        
        return finalAmountPlusTip
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Qual o valor da conta?", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Escolha o número de pessoas", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) pessoas")
                        }
                    }
                }
                
                Section("Qual o percentual da gorjeta?") {
                    Picker("Gorjeta", selection: $tipPercentage) {
                        ForEach(tipPercentageSuggestions, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    //                    .pickerStyle(.segmented)
                    .pickerStyle(.navigationLink)
                    
                }
                Section ("Amount per person"){
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        //Go back to project 1 and use a conditional modifier to change the total amount text view to red if the user selects a 0% tip.

                        .foregroundColor(tipPercentageSuggestions[tipPercentage] == 0 ? Color.red : Color.primary)
                }
                Section ("Total amount for everyone + tip") {
                    Text(amountPlusTip, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
