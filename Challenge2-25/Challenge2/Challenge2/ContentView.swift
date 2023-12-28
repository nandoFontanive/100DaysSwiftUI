//
//  ContentView.swift
//  Challenge2
//
//  Created by Fernando Fontanive on 26/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var randomObjective = Int.random(in: 0...1)
    @State private var randomChoice = Int.random(in: 0...2)
    @State private var points = 0
    @State private var roundsPlayed = 0
    @State private var scoreTitle = "Aguardando!"
    @State private var showingScore = false
    @State private var isGameFinished = false
    
    var possibleObjectives = ["Win", "Lose"]
    var possibleChoices = ["Rock", "Paper", "Scissor"]
    var winningChoices = ["Paper", "Scissor", "Rock"]
    
    
    
    var body: some View {
        VStack {
            Text("Pedra, papel ou tesoura")
                .font(.system(size: 30))
//            Text("Objetivo sorteado: \(possibleObjectives[randomObjective]) (\(randomObjective))")
//            Text("Jogada sorteada: \(possibleChoices[randomChoice]) (\(randomChoice))")
//            Text("Jogada vencedora: \(winningChoices[randomChoice]) (\(randomChoice))")
            Text("Pontos do jogador: \(points)")
            Text("Rounds jogados: \(roundsPlayed)")
            
            Spacer()
            
            HStack {
                Button {
                    buttonTapped(0)
                } label: {
                    Text("🪨")
                        .padding()
                        .foregroundStyle(.white)
                        .background(.blue)
                        .clipShape(.capsule)
                        .font(.system(size: 80))
                }
                
                Button {
                    buttonTapped(1)
                } label: {
                    Text("🧻")
                        .padding()
                        .foregroundStyle(.white)
                        .background(.blue)
                        .clipShape(.capsule)
                        .font(.system(size: 80))
                }
                
                Button {
                    buttonTapped(2)
                } label: {
                    Text("✂️")
                        .padding()
                        .foregroundStyle(.white)
                        .background(.blue)
                        .clipShape(.capsule)
                        .font(.system(size: 80))
                }
            }
            Text("\(scoreTitle)")
        }
        .alert(scoreTitle, isPresented: $isGameFinished) {
            Button("Continue", action: scoreReset)
        } message: {
            Text("Your score is \(points)!")
        }
        .frame(height: 200)
    }
    func buttonTapped(_ escolhaUsuario: Int) {
        if escolhaUsuario  == randomChoice && randomObjective == 0 {
            scoreTitle = "Acertou escolha e objetivo! Ganhou um ponto!"
            points += 1
        }
        else if escolhaUsuario != randomChoice && randomObjective == 1 {
            scoreTitle = "Acertou somente objetivo! Ganhou um ponto!"
            points += 1
        } else {
            scoreTitle = "Errou! Perdeu um ponto!"
            points -= 1
        }
        roundsPlayed += 1
        nextRound()
//        randomObjective = Int.random(in: 0...1)
//        randomChoice = Int.random(in: 0...2)
    }
    
    func nextRound() {
        if roundsPlayed == 10 {
            isGameFinished = true
            scoreTitle = "Fim!"
        }
        else {
            randomObjective = Int.random(in: 0...1)
            randomChoice = Int.random(in: 0...2)
        }
    }
    
    func scoreReset() {
        roundsPlayed = 0
        points = 0
    }
}


#Preview {
    ContentView()
}
