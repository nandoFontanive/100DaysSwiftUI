//
//  CardView.swift
//  Flashzilla
//
//  Created by Fernando Fontanive on 17/10/24.
//

import SwiftUI

struct CardView: View {
    @State private var isShowingAnswer = false
    let card: Card
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .shadow(radius: 10)
            
            VStack {
                Text(card.prompt)
                    .font(.largeTitle)
                    .foregroundStyle(.black)
                
                if isShowingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundStyle(.secondary)
                }
            }
                    .padding(20)
                    .multilineTextAlignment(.center)
        }
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .frame(width: 400, height: 250)
    }
}

#Preview {
    CardView(card: .example)
}
