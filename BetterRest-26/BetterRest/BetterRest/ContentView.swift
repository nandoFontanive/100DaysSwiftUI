//
//  ContentView.swift
//  BetterRest
//
//  Created by Fernando Fontanive on 27/12/23.
//

import CoreML
import SwiftUI


struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var mensagem = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack {
            Form {
//                VStack(alignment: .leading, spacing: 0) {
                Section {
                    Text("Quando quer acordar?")
                        .font(.headline)
                    
                    DatePicker("Digite uma data", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
//                VStack(alignment: .leading, spacing: 0) {
                Section {
                    Text("Quanto quer mimir?")
                        .font(.headline)
                    
                    Stepper("\(sleepAmount.formatted()) horas", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
//                VStack(alignment: .leading, spacing: 0) {
                Section {
                    Text("Quanto café tomou?")
                        .font(.headline)
                    
                    //Replace the “Number of cups” stepper with a Picker showing the same range of values.

                    Picker("Escolha o número", selection: $coffeeAmount) {
                        ForEach(0..<11) {
                            Text("\($0) xícaras")
                        }
                    }
//                   Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 0...10, step: 1)
//                   Stepper(coffeeAmount == 1 ? "1 xícara" : "\(coffeeAmount) xícaras", value: $coffeeAmount, in: 0...10, step: 1)
                }

                //Change the user interface so that it always shows their recommended bedtime using a nice and large font. You should be able to remove the “Calculate” button entirely.
                Section {
                    Text("Você deve dormir às:")
                    Text(calcularHoraMimir())
//LINHA DE SINTAXE QUE EU NÃO SABIA QUE EXISTIA (-_-)'
                }
            }
            .navigationTitle("BetterRest")
//            .toolbar {
//                Button("Calcular", action: calcularHoraMimir)
//                
//            }
//            .alert(alertTitle, isPresented: $showingAlert) {
//                Button("OK") { }
//            } message: {
//                Text(alertMessage)
//            }
        }
        
        
    }
    func calcularHoraMimir() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Int64(Double(hour + minute)), estimatedSleep: sleepAmount, coffee: Int64(Double(coffeeAmount)))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
//            alertTitle = "Sua hora de mimir ideal é..."
            let mensagem = "\(sleepTime.formatted(date: .omitted, time: .shortened))"
            return mensagem
            
        } catch {
            alertTitle = "Erro"
            alertMessage = "Algo deu errado"
            return "Erro"
        }
    }
}

#Preview {
    ContentView()
}
