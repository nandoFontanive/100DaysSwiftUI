//
//  ListLayoutView.swift
//  Moonshot
//
//  Created by Fernando Fontanive on 11/01/24.
//

import SwiftUI

struct ListLayoutView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationStack {
            VStack {
//                List {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                    
                
                //            .listStyle(.plain)
                .navigationTitle("Moonshot")
                //            .background(.darkBackground)
                .preferredColorScheme(.dark)
            }
        }
    }
}
#Preview {
    ListLayoutView()
}

