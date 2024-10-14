//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Fernando Fontanive on 14/10/24.
//

import SwiftUI

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted people"
        case .uncontacted:
            "Uncontacted people"
        }
    }
    
    var body: some View {
        NavigationStack {
            Text("Hello!")
                .navigationTitle(title)
            
        }
    }
}
    
    #Preview {
        ProspectsView(filter: .none)
    }
