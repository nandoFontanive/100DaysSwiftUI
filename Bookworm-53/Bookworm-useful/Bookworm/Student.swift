//
//  Student.swift
//  Bookworm
//
//  Created by Fernando Fontanive on 20/01/24.
//

import SwiftData
import Foundation

@Model
class Student {
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
