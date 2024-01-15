//
//  ListLayoutView.swift
//  Moonshot
//
//  Created by Fernando Fontanive on 11/01/24.
//

import SwiftUI
//
struct ListLayoutView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(missions) { mission in
                    NavigationLink(value: mission) {
                        //Return to project 8 (Moonshot), and upgrade it to use NavigationLink(value:). This means adding Hashable conformance, and thinking carefully how to use navigationDestination().
                        //                    NavigationLink {
//                        MissionView(mission: mission, astronauts: astronauts)
                        
                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                    }
                    .navigationDestination(for: Mission.self) { mission in
                        MissionView(mission: mission, astronauts: astronauts)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
    
    }


#Preview {
    ListLayoutView()
}

