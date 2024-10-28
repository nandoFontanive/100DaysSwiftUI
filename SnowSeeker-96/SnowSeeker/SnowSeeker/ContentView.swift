//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Fernando Fontanive on 27/10/24.
//

import SwiftUI

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct ContentView: View {
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false
    
    var body: some View {
        Button("Tap me") {
            selectedUser =  User()
            isShowingUser = true
        }
        .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
            Button(user.id) { }
        }
        }
        }
    


#Preview {
    ContentView()
}
//        NavigationSplitView(columnVisibility: .constant(.all)) {
//                Text("Primary")
//            } detail: {
//                Text("Seconday")
//            }
//            .navigationSplitViewStyle(.balanced)

//        .sheet(item: $selectedUser) { unwrappedUserValue in
//            Text(unwrappedUserValue.id)
