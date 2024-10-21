//
//  Card.swift
//  Flashzilla
//
//  Created by Fernando Fontanive on 17/10/24.
//

import Foundation

struct Card: Codable {
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "Who played the 12th Doctor in the Doctor Who series?", answer: "Matt Smith")
}
