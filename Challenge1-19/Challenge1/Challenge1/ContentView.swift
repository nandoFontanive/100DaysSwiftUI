//
//  ContentView.swift
//  Challenge1
//
//  Created by Fernando Fontanive on 16/12/23.
//
// Biggest issue was using a dictionary to store the units : ratio of the different units

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var selectedKindOfUnit = 1
    @State private var selectedKindOfResultUnit = 1
    
    let mililitresInUnit = ["Litre": 1000, "Cup": 240, "Pint": 473.176, "Gallon": 3785.41, "Mililitre": 1]
    
    let kindOfUnit = ["Mililitre", "Cup", "Pint", "Litre", "Gallon"]
    
    var enteredValueInMl: Double {
        let unitAmount = Double(checkAmount) ?? 0
        let mililitresInOneUnit = mililitresInUnit[kindOfUnit[selectedKindOfUnit]] ?? 0
        let mililitresInUnits = unitAmount * mililitresInOneUnit
        
        return mililitresInUnits
    }
    
    var resultValue: Double {
        let kindOfResultUnit = mililitresInUnit[kindOfUnit[selectedKindOfResultUnit]] ?? 0
        let result = enteredValueInMl / kindOfResultUnit
        
        return result
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Amount of unit") {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Kind of unit for convert")) {
                    Picker("Kind of unit", selection: $selectedKindOfUnit) {
                        ForEach(0 ..< kindOfUnit.count) {
                            Text("\(self.kindOfUnit[$0])")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Result for converted unit") {
                    Text("\(self.resultValue, specifier: "%.2f")")
                }
                
                Section("Kind for converted unit") {
                    Picker("Kind of unit", selection: $selectedKindOfResultUnit) {
                        ForEach(0 ..< kindOfUnit.count) {
                            Text("\(self.kindOfUnit[$0])")
                        }
                    }
                    
                    .pickerStyle(.segmented)
                }
                .navigationBarTitle("Unit Converter")
            }
        }
    }
}



//    @State private var input: Double = 0.0
//    @State private var output: Double = 0.0
//    @State private var unitInput = ["m", "kms", "pés", "jardas", "milhas"]
//    @FocusState private var inputIsFocused: Bool
//
//    @State private var unitOutput = ["m", "kms", "pés", "jardas", "milhas"]
//
//    var conversionFactors: [String: Double] = [
//        "km_m": 1000,
//        "pés_m": 1 / 3.281,
//        "jardas_m": 1 / 1.094,
//        "milhas_m": 1609
//    ]
//
//    var convertedValue: Double {
//        let inputUnit = unitInput.first ?? ""
//        let outputUnit = unitOutput.first ?? ""
//
//        let factorKey = "\(inputUnit)_\(outputUnit)"
//        let factor = conversionFactors[factorKey] ?? 1.0
//
//        return input * factor
//    }
//
////
////    var convertKilometersToMeters: Double {
////        let inputKilometers = Double(input)
////        let outputKilometersToMeters = (input / 1000)
////        return outputKilometersToMeters
////    }
////
////    var convertFeetToMeters: Double {
////        let inputFeet = Double(input)
////        let outputFeetToMeters = (input / 3.281)
////        return outputFeetToMeters
////    }
////
////    var convertYardsToMeters: Double {
////        let inputYards = Double(input)
////        let outputYardsToMeters = (input / 1.094)
////        return outputYardsToMeters
////    }
////
////    var convertMilesToMeters: Double {
////        let inputMiles = Double(input)
////        let outputMilesToMeters = (input * 1609)
////        return outputMilesToMeters
////    }
//
//
//    var body: some View {
//        NavigationStack {
//            Form {
//                Section ("Insira valor e unidade a serem convertidos"){
//                    TextField("Qual o valor a ser convertido?", value: $input, format: .number)
//                        .keyboardType(.decimalPad)
//                        .focused($inputIsFocused)
//
//                    Picker ("Escolha a unidade de origem", selection: $unitInput){
//                        ForEach(unitInput, id: \.self) {
//                            Text("\($0)")
//                        }
//                    }
//                    .pickerStyle(.segmented)
//                }
//                Section ("Escolha a unidade de destino") {
//
//                    Picker ("Escolha a unidade de destino", selection: $unitOutput) {
//                        ForEach(unitOutput, id: \.self) {
//                            Text("\($0)")
//                        }
//                    }
//                    .pickerStyle(.segmented)
//                }
//                Section ("Resultado da conversão") {
//
//                    Text("\(convertedValue, specifier: "%.2f")")
//                }
//            }
//            .navigationTitle("Unit Converter")
//            .toolbar {
//                if inputIsFocused {
//                    Button("Feito") {
//                        inputIsFocused = false
//                    }
//                }
//            }
//        }
//    }
//}

#Preview {
    ContentView()
}


/*
 
 
 struct ContentView: View {
     @State private var inputUnit:Int = 1
     @State private var outputUnit:Int = 1
     @State private var inputNumber:Int = 1
     @FocusState private var inputNumberIsFocused: Bool

     let units = [1, 60, 3600, 86400]
     let unitsDisplay = [
         1 : "Seconds",
         60 : "Minutes",
         3600 : "Hours",
         86400 : "Days"
     ]

     var convertedNumber: Int {
         let converted = inputNumber * inputUnit / outputUnit;
         return converted
     }

     var body: some View {
         NavigationView {
             Form {
                 Section {
                     TextField("Amount", value: $inputNumber, format: .number)
                         .keyboardType(.numberPad)
                         .focused($inputNumberIsFocused)
                 } header: {
                     Text("Number to Convert")
                 }

                 Section {
                     Picker("Input Units", selection: $inputUnit) {
                         ForEach(units, id: \.self) {
                             if let label = unitsDisplay[$0] {
                                 Text(label)
                             }
                         }
                     }
                     .pickerStyle(.segmented)
                 } header: {
                     Text("Convert From")
                 }

                 Section {
                     Picker("Input Units", selection: $outputUnit) {
                         ForEach(units, id: \.self) {
                             if let label = unitsDisplay[$0] {
                                 Text(label)
                             }
                         }
                     }
                     .pickerStyle(.segmented)
                 } header: {
                     Text("Convert To")
                 }

                 Section {
                     Text(convertedNumber, format: .number)
                 } header: {
                     Text("Converted Number")
                 }
             }
             .navigationTitle("Convert It!")
             .toolbar {
                 ToolbarItemGroup(placement: .keyboard) {
                     Spacer()

                     Button("Done") {
                         inputNumberIsFocused = false
                     }
                 }
             }
         }
     }
 }

 struct ContentView_Previews: PreviewProvider {
     static var previews: some View {
         ContentView()
     }
 }
 */
