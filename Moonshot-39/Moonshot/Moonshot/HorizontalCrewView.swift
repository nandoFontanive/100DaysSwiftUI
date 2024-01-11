//
//  HorizontalCrewView.swift
//  Moonshot
//
//  Created by Fernando Fontanive on 11/01/24.
//

import SwiftUI

struct HorizontalCrewView: View {
    
    var crew: [MissionView.CrewMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(.capsule)
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                    )
                            
                            VStack(alignment: .leading) {
                                
                                Text(crewMember.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                
                                Text(crewMember.role)
                                    .foregroundStyle(.white.opacity(0.5))
                                    
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

