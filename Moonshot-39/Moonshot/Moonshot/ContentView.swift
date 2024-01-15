//
//  ContentView.swift
//  Moonshot
//
//  Created by Fernando Fontanive on 09/01/24.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingMissionsAsList = true
    //Return to project 8 (Moonshot), and upgrade it to use NavigationLink(value:). This means adding Hashable conformance, and thinking carefully how to use navigationDestination().

//    @State private var path = [Int]()
    
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
//        NavigationStack {
//        NavigationStack(path: $path) {
        NavigationStack {
            //            ScrollView {
            //            ScrollView {
            //For a tough challenge, add a toolbar item to ContentView that toggles between showing missions as a grid and as a list.
            //            if showingMissionsAsList {
            //                List {
            //                    ForEach(missions) { mission in
            //                        NavigationLink {
            //                            MissionView(mission: mission, astronauts: astronauts)
            //                        } label: {
            //                            VStack {
            //                                VStack {
            //                                    Text(mission.displayName)
            //                                        .font(.headline)
            //                                        .foregroundStyle(.white)
            //                                }
            //                            }
            //                        }
            //                    }
            //                }
            //
            //
            //                //                LazyVGrid(columns: columns) {
            //                //                    ForEach(missions) { mission in
            //                //                        NavigationLink {
            //                //                            MissionView(mission: mission, astronauts: astronauts)
            //                //                        } label: {
            //                //                            VStack {
            //                //                                Image(mission.image)
            //                //                                    .resizable()
            //                //                                    .scaledToFit()
            //                //                                    .frame(width: 100, height: 100)
            //                //                                    .padding()
            //                //
            //                //                                VStack {
            //                //                                    Text(mission.displayName)
            //                //                                        .font(.headline)
            //                //                                        .foregroundStyle(.white)
            //                //
            //                //                                    Text(mission.formattedLauchDate)
            //                //                                        .font(.caption)
            //                //                                        .foregroundStyle(.white.opacity(0.5))
            //                //                                }
            //                //                                .padding(.vertical)
            //                //                                .frame(maxWidth: .infinity)
            //                //                                .background(.lightBackground)
            //                //                            }
            //                //                            .clipShape(.rect(cornerRadius: 10))
            //                //                            .overlay(RoundedRectangle(cornerRadius: 10)
            //                //                                .stroke(.lightBackground)
            //                //                            )
            //                //                        }
            //                //                    }
            //                //                }
            //                //                .padding([.horizontal, .bottom])
            //                .listStyle(.plain)
            ////                .listRowBackground(Color.darkBackground)
            //                .navigationTitle("Moonshot")
            //                .background(.darkBackground)
            //                .preferredColorScheme(.dark)
            //
            //            }
            //            else {
            //                            ScrollView {
            //                                LazyVGrid(columns: columns) {
            //                                    ForEach(missions) { mission in
            //                                        NavigationLink {
            //                                            MissionView(mission: mission, astronauts: astronauts)
            //                                        } label: {
            //                                            VStack {
            //                                                Image(mission.image)
            //                                                    .resizable()
            //                                                    .scaledToFit()
            //                                                    .frame(width: 100, height: 100)
            //                                                    .padding()
            //
            //                                                VStack {
            //                                                    Text(mission.displayName)
            //                                                        .font(.headline)
            //                                                        .foregroundStyle(.white)
            //
            //                                                    Text(mission.formattedLauchDate)
            //                                                        .font(.caption)
            //                                                        .foregroundStyle(.white.opacity(0.5))
            //                                                }
            //                                                .padding(.vertical)
            //                                                .frame(maxWidth: .infinity)
            //                                                .background(.lightBackground)
            //                                            }
            //                                            .clipShape(.rect(cornerRadius: 10))
            //                                            .overlay(RoundedRectangle(cornerRadius: 10)
            //                                                .stroke(.lightBackground)
            //                                            )
            //                                        }
            //                                    }
            //                                }
            //                                .padding([.horizontal, .bottom])
            //
            //                .navigationTitle("Moonshot")
            //                .background(.darkBackground)
            //                .preferredColorScheme(.dark)
            //                .toolbar {
            //                    Button("Change view", systemImage: "rectangle.grid.1x2.fill") {
            //                        showingMissionsAsList = true
            //                    }
            //                }
            //            }
            //
            //            }
            
            //suggested way, two views:
            Group {
                if showingMissionsAsList {
                    ListLayoutView()
                } else {
                    GridLayoutView()
                }
            }
            .navigationTitle("Moonshot")
            .toolbar {
                Button("Change view", systemImage: "rectangle.grid.1x2.fill") {
                    showingMissionsAsList.toggle()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
