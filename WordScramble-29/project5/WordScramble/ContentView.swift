//
//  ContentView.swift
//  WordScramble
//
//  Created by Paul Hudson on 15/10/2023.
// juro que eu tb fiz o meu - n -


import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("Pontos: \(score)")
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
//            Add a toolbar button that calls startGame(), so users can restart with a new word whenever they want to.

            .toolbar {
                Button("Novo jogo", action: startGame)
            }
            .navigationTitle("A palavra é \(rootWord)")
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) { } message: {
                Text(errorMessage)
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let wordScore = addingScores(word: answer)
        
        //Disallow answers that are shorter than three letters or are just our start word.
        //        guard answer.count > 3 else { return }
        //        guard answer.count > 0 else { return }
        // ou da forma mais bonitinha, com func wordLongerThanTreeLetters e wordIsDifferentFromRootWord
        
        guard wordIsDifferentFromRootWord(word: answer) else {
            wordError(title: "Word same as original", message: "Word inserted can't be the same as the original word \(rootWord)")
            return
        }
        
        guard wordLongerThanTreeLetters(word: answer) else {
            wordError(title: "Word too short", message: "Word should have more than 3 letters")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        //Put a text view somewhere so you can track and show the player’s score for a given root word. How you calculate score is down to you, but something involving number of words and their letter count would be reasonable.

//      jeito mais fácil, assim:
//        score += 1 + (newWord.count)
        // jeito mais bonitinho, com uma função pra somar os pontos - cria uma variável pra isso (wordScore) e pra definir ela chama a função, assim:    let wordScore = addingScores(word: answer)   , depois só exibe o score, como na linha abaixo
        score += wordScore
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                usedWords = [String]()
                score = 0
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func wordLongerThanTreeLetters(word: String) -> Bool {
        word.count > 3
//        if word.count > 3 {
//            return true
//        }
//        else {
//            return false
//        }
    }
    
    func wordIsDifferentFromRootWord(word: String) -> Bool {
        word != rootWord
//        if word != rootWord {
//            return true
//        }
//        else {
//            return false
//        }
    }
    
    func addingScores(word: String) -> Int {
//        var totalPoints = 0
//        totalPoints += 1 + (word.count)
//        return totalPoints
        return 1 + word.count
    }
    
}
#Preview {
    ContentView()
}
