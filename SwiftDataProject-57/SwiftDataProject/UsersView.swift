//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Fernando Fontanive on 24/01/24.
//

import SwiftData
import SwiftUI



struct UsersView: View {
    @Query var users: [User]

    
    var body: some View {

        List(users) { user in
            Text(user.name)
        }
    }
}

#Preview {
    UsersView()
        .modelContainer(for: User.self)
}
