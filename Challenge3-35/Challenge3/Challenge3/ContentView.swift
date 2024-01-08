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
    
    struct QuestionAndAnswer {
        var operand1: Int
        var operand2: Int
        
        var answer: Int {
            operand1 * operand2
        }
        var questionText: String {
            "\(operand1) * \(operand2)"
        }
    }
    
    @State private var multiplicationTable = 2
    @State private var numberOfQuestions = [5, 10, 15, 20]
    @State private var numberOfQuestion = 0
    
    @State private var questionArray = [String]()
    @State private var answerArray = [Int]()
    
    @State private var userAnswer: Int = 0
    @State private var answer = 0
    
    @State private var currentQuestion = 0
    @State private var displayQuestion = " "
    
    @State private var score = 0
    
    @State private var playingGame = false
    @State private var configuringGame = true
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var gameOver = false
    
    var body: some View {
        NavigationStack {
            Form {
                if configuringGame {
                    Section {
                        Picker("Selecione tabuada", selection: $multiplicationTable) {
                            ForEach(2..<13, id: \.self) {
                                Text("\($0)")
                            }
                        }
                    } header: {
                        Text("Selecione o valor")
                    }
                    Section {
                        Picker("Quantas perguntas quer responder?", selection: $numberOfQuestion) {
                            ForEach(numberOfQuestions, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                    } header: {
                        Text("Quantidade questões")
                    }
                    Button("Iniciar!") {
                        configureGame()
                    }
                }
                if playingGame {
                    Section {
                        Text(displayQuestion)
                        Section {
                            TextField("Resposta usuário", value: $userAnswer, format: .number)
                            Button("Checar resposta") {
                                checkAnswer()
                            }
                        }
                        Section {
                            Text("Pontuação = \(score)")
                        }
                    }
                    .onAppear(perform: setQuestion)
                    .alert(alertMessage, isPresented: $showAlert) {
                        Button("Ok") {
                            if gameOver {
                                startNewGames()
                            } else {
                                
                            }
                        }
                    }
                }
            }
            .navigationTitle("JogoTabulada")
        }
    }
        
        func configureGame() {
            playingGame = true
            configuringGame = false
            gameOver = false
            
            var count = 0
            while count < numberOfQuestion {
                let randomNum = Int.random(in: 0...12)
                let problem = QuestionAndAnswer(operand1: multiplicationTable, operand2: randomNum)
                
                let questionTexts = problem.questionText
                let questionAnswer = problem.answer
                
                questionArray.append(questionTexts)
                answerArray.append(questionAnswer)
                
                count += 1
            }
            print(questionArray)
            print(answerArray)
        }
        
    func setQuestion() {
        if currentQuestion != numberOfQuestion {
            let displaysQuestion = questionArray[currentQuestion]
            displayQuestion = displaysQuestion
            
            let setAnswer = answerArray[currentQuestion]
            answer = setAnswer
            
            userAnswer = 0
        } else {
            showAlert = true
            alertMessage = "Fim do jogo"
            gameOver = true
        }
    }
        
        func checkAnswer() {
            if answer == userAnswer {
                score += 1
                alertMessage = "Certo!"
            } else {
                score -= 1
                alertMessage = "Errou, resposta é \(userAnswer)"
            }
            currentQuestion += 1
            showAlert = true
            setQuestion()
        }
        
        func startNewGames() {
            currentQuestion = 0
            numberOfQuestion = 0
            score = 0
            playingGame = false
            configuringGame = true
        }
}

