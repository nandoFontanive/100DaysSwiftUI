//
//  ContentView.swift
//  Challenge3
//
//  Created by Fernando Fontanive on 04/01/24.
//
/*
 The player needs to select which multiplication tables they want to practice. This could be pressing buttons, or it could be an “Up to…” stepper, going from 2 to 12.
 The player should be able to select how many questions they want to be asked: 5, 10, or 20.
 You should randomly generate as many questions as they asked for, within the difficulty range they asked for.
 ----------
 
 Start with an App template, then add some state to determine whether the game is active or whether you’re asking for settings.
 Generate a range of questions based on the user’s settings.
 Show the player how many questions they got correct at the end of the game, then offer to let them play again. */


import SwiftUI



struct ContentView: View {
    
    struct PerguntaResposta {
        var fator1: Int
        var fator2: Int
        
        var answer: Int {
            fator1 * fator2
        }
        var textoQuestao: String {
            "\(fator1) * \(fator2)"
        }
    }
    
    @State private var chosenTable = 2
    @State private var numberQuestions = [5, 10, 15, 20]
    @State private var chosenNumberQuestions = 0
    
    @State private var questionsBank = [String:Int]()
    @State private var answersBank = [Int]()
    
    @State private var userAnswer = 0
    @State private var correctAnswer = 0
    
    @State private var currentQuestion = 0
    @State private var displayQuestion = 0
    
    @State private var score = 0
    
    @State private var isGameActive = false
    @State private var isSettingActive = true
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var gameOver = false
    
    //    let startGame: (Int) -> Void
    //
    //    init(startGame: @escaping (Int) -> Void = { _ in }) {
    //        self.startGame = startGame
    //    }
    
    var body: some View {
        NavigationStack {
            Form {
                if isGameActive {
                    GameView(chosenNumberQuestions: chosenNumberQuestions)
                } else {
                    GameSettingsView(startGame: startGame)
                }
            }
            .navigationTitle("JogoTabulada")
        }
        
        func startGame(with chosenNumberQuestions: Int) {
            self.chosenNumberQuestions = chosenNumberQuestions
            isGameActive = true
            isSettingActive = false
            generateQuestions()
        }
        
        func generateQuestions() {
            for _ in 1...chosenNumberQuestions {
                let f1 = Int.random(in: 1...10)
                let f2 = Int.random(in: 2...12)
                let question = "\(f1) * \(f2) é "
                let correctAnswer = f1 * f2
                questionsBank[question] = correctAnswer
            }
            print(questionsBank)
            questionsBank = [:]
        }
        
        func userAnswersQuestion() {
        }
    }
    
    struct GameView: View {
        let chosenNumberQuestions: Int
        @State private var userAnswersQuestion = 0
        @State private var resposta = 0
        
        var body: some View {
            
            Text("Digite a resposta certa \(chosenNumberQuestions)")
            Text("Qual o valor de")
            //                                                                        Text(questionsBank[0] ?? nil)
            
            Section("Resposta") {
                
                //            TextField("Digite a resposta", value: $resposta, format: .number) {
                //            }
                //            .keyboardType(.decimalPad)
                
                //            Button("Responder")
                //                .background(.blue)
                //                .foregroundColor(.white)
                //                .buttonStyle(.bordered)
            }
        }
    }
    
    struct GameSettingsView: View {
        @State private var chosenTable = 2
        @State var chosenNumberQuestions = 0
        let startGame: (Int) -> Void
        
        var body: some View {
            
            VStack {
                HStack {
                    Image(systemName: "number.circle")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Jogo da taubulada")
                    Image(systemName: "number.circle")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                }
                Form {
                    Section {
                        Text("Escolha a tabuada desejada")
                        Stepper("Tabuada do \(chosenTable)", value: $chosenTable, in: 2...12, step: 1)
                    }
                    Section {
                        Text("Quantas perguntas quer responder?")
                        Picker("\(chosenNumberQuestions) perguntas", selection: $chosenNumberQuestions) {
                            ForEach(1..<50) {
                                Text("\($0)")
                            }
                        }
                        
                        Button("Iniciar!") { startGame(chosenNumberQuestions) }
                        
                            .background(.blue)
                            .foregroundColor(.white)
                            .buttonStyle(.bordered)
                    }
                }
            }
        }
    }
    
    #Preview {
        ContentView()
    }
    
