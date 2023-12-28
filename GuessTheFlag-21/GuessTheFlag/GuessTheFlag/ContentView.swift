//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Fernando Fontanive on 18/12/23.

import SwiftUI

// Create a custom ViewModifier (and accompanying View extension) that makes a view have a large, blue font suitable for prominent titles in a view.

struct customLargeBlueFontTitleViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.yellow)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var gameEnd = ""
    @State private var isGameFinished = false
    
    @State private var userScore = 0
    @State private var totalQuestionsAnswered = 0
    
    //Go back to project 2 and replace the Image view used for flags with a new FlagImage() view that renders one flag image using the specific set of modifiers we had.

    struct FlagImage: View {
        var flag: String
        var body: some View {
            Image(flag)
                .clipShape(Capsule())
                .shadow(color: .black, radius: 5)
        }
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            //            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                        Text("Jogo do Adivinhe!")
                            .modifier(customLargeBlueFontTitleViewModifier())
                    
                
                
                Text("Adivinhe a bandeira!")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Toque a bandeira correta")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(flag: self.countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(userScore)!")
        }
        .alert(scoreTitle, isPresented: $isGameFinished) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your final score is \(userScore), you have played \(totalQuestionsAnswered) rounds")
        }
    }
    
    
    func flagTapped(_ number: Int) {
        totalQuestionsAnswered += 1
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
        } else {
            scoreTitle = "Wrong, this is the flag of \(countries[number])"
            //^ bom pra entender o conceito de puxar a escolha (number) do array de países
        }
        showingScore = true
    }
    
    func askQuestion() {
        if totalQuestionsAnswered == 3 {
            isGameFinished = true
            scoreTitle = "Fim do jogo!"
            
        }
        else {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    }
    
    
    func restartGame() {
        totalQuestionsAnswered = 0
        userScore = 0
        isGameFinished = false
        askQuestion()
    }
}



#Preview {
    ContentView()
}
