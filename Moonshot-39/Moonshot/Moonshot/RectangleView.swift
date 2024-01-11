//
//  RectangleView.swift
//  Moonshot
//
//  Created by Fernando Fontanive on 11/01/24.
//

import SwiftUI

struct RectangleView: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}

#Preview {
    RectangleView()
}
