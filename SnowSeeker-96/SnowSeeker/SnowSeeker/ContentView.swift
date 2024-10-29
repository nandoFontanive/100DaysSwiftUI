//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Fernando Fontanive on 27/10/24.
//

import SwiftUI

@Observable
class PlayerClass {
    var name = "Anon"
    var highScore = 0
}

struct highScoreView: View {
    @Environment(PlayerClass.self) var playerHighScoreViewVariable
    
//    var playerVariableOnHighScoreView: PlayerClass
    
    var body: some View {
        @Bindable var playerBindableVariable = playerHighScoreViewVariable
        Stepper("Hello \(playerBindableVariable.name)!\nYour high score is: \(playerBindableVariable.highScore)", value: $playerBindableVariable.highScore)
//        Text("Your high score is \(playerHighScoreViewVariable.highScore)")
    }
}

struct ContentView: View {
    @State private var playerContentViewVariable = PlayerClass()
    
    var body: some View {
        VStack {
            Text("Welcome!")
            highScoreView()
//            highScoreView(playerVariableOnHighScoreView: playerVariableOnContentView)
        }
        .environment(playerContentViewVariable)
    }
}

//#Preview {
//    ()
//}


//struct ContentView: View {
//
//    @State private var searchText = ""
//
//    let allNames = ["Ana", "Bianca", "Carla", "Dani"]
//    var filteredNames: [String] {
//
//        if searchText.isEmpty {
//            allNames
//        } else {
//            allNames.filter { oneNameComingIn in
//                oneNameComingIn.localizedStandardContains(searchText)
//            }
//        }
//    }
//        var body: some View {
//            NavigationStack {
//                List(filteredNames, id: \.self) { name in
//                    Text(name)
//                }
//                Text("Searching for \(searchText)")
//                    .searchable(text: $searchText, prompt: "Look for something")
//                    .navigationTitle("Search Page")
//
//            }
//        }
//    }
//        Group {
//            Text("Name")
//            Text("Country")
//            Text("Pets")
//        }
//        .font(.largeTitle)
//        ViewThatFits {
//            Rectangle()
//                .frame(width: 500, height: 200)
//
//            Circle()
//                .frame(width: 200, height: 200)
//        }
//        }
//    @Environment(\.horizontalSizeClass) var horizontalSizeClass
//        if horizontalSizeClass == .compact {
//            VStack (content: UserView.init)
//            } else {
//                HStack {
//                    UserView()
//                }
//            }
//    @State private var layoutVertically = false
//        Button {
//            layoutVertically.toggle()
//        } label: {
//struct User: Identifiable {
//    var id = "Taylor Swift"
//}
//    @State private var selectedUser: User? = nil
//    @State private var isShowingUser = false
//        Button("Tap me") {
//            selectedUser =  User()
//            isShowingUser = true
//        }
//        .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
//            Button(user.id) { }
//        }
//        }
//        }
//        NavigationSplitView(columnVisibility: .constant(.all)) {
//                Text("Primary")
//            } detail: {
//                Text("Seconday")
//            }
//            .navigationSplitViewStyle(.balanced)

//        .sheet(item: $selectedUser) { unwrappedUserValue in
//            Text(unwrappedUserValue.id)




=============================


import SwiftUI

@Observable
class PlayerClass {
    var name = "Anon"
    var highScore = 0
}

struct highScoreView: View {
    @Environment(PlayerClass.self) var playerHighScoreViewVariable
    
    var body: some View {
        @Bindable var playerBindableVariable = playerHighScoreViewVariable
        Stepper("Hello \(playerBindableVariable.name)!\nYour high score is: \(playerBindableVariable.highScore)", value: $playerBindableVariable.highScore)
    }
}

struct ContentView: View {
    @State private var playerContentViewVariable = PlayerClass()
    
    var body: some View {
        VStack {
            Text("Welcome!")
            highScoreView()
        }
        .environment(playerContentViewVariable)
    }
}
