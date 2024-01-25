//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Fernando Fontanive on 23/01/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    //    @Query(filter: #Predicate<User> { user in
    //        if user.name.localizedStandardContains("R") {
    //            if user.city == "London" {
    //                return true
    //            } else {
    //                return false
    //            }
    //        } else {
    //            return false
    //        }
    //    }, sort: \User.name) var users: [User]
    //    @State private var path = [User]()
    @State private var showingUpcomingOnly = false
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate)]
    
    
    var body: some View {
        //        NavigationStack(path: $path) {
        NavigationStack {
            UsersView(minimumJoinDate: showingUpcomingOnly ? .now : .distantPast, sortOrder: sortOrder)
            //            List(users) { user in
            //                NavigationLink(value: user) {
            //                Text(user.name)
            //            }
            
                .navigationTitle("Users")
            //            .navigationDestination(for: User.self) { user in
            //                EditUserView(user: user)
                .toolbar {
                    Button(showingUpcomingOnly ? "Show Everyone" : "Show Upcoming") {
                        showingUpcomingOnly.toggle()
                    }
                    Button("Add Samples", systemImage: "plus") {
                        try? modelContext.delete(model: User.self)
                        let first = User(name: "Ed", city: "Landan", joinDate: .now.addingTimeInterval(86400 * -10))
                        let second = User(name: "Rosa", city: "London", joinDate: .now.addingTimeInterval(86400 * -5))
                        let third = User(name: "Jon", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
                        let fourth = User(name: "Sansa", city: "Kiev", joinDate: .now.addingTimeInterval(86400 * 10))
                        //                            let user = User(name: "", city: "", joinDate: .now)
                        //                            modelContext.insert(user)
                        //                            path = [user]
                        modelContext.insert(first)
                        modelContext.insert(second)
                        modelContext.insert(third)
                        modelContext.insert(fourth)
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
