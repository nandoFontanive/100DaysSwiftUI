//
//  Prospect.swift
//  HotProspects
//
//  Created by Fernando Fontanive on 14/10/24.
//

import SwiftData

@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    
    init(name: String, email: String, isContacted: Bool) {
        self.name = name
        self.emailAddress = email
        self.isContacted = isContacted
    }
}
