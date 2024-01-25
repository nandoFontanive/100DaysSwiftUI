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
    
    init(minimumJoinDate: Date) {
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= minimumJoinDate
        }, sort: \User.name)
    }


    
    var body: some View {

        List(users) { user in
            Text(user.name)
            
        }
    }
}

#Preview {
    UsersView(minimumJoinDate: .now)
        .modelContainer(for: User.self)
}
