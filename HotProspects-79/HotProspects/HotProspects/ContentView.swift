//
//  ContentView.swift
//  HotProspects
//
//  Created by Fernando Fontanive on 11/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = "One"
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Button("Show Tab 2") {
                selectedTab = "dois"
            }
            .tabItem {
                Label("One", systemImage: "star")
            }
            .tag("um")
            
            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "globe")
                }
                .tag("dois")
            
        }
        
    }
}

#Preview {
    ContentView()
}
