//
//  Item.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 06.02.2024..
//

import Foundation

struct Item: Identifiable, Codable {
    let id: UUID
    var name: String
    var quantity: Int
    var creationDate: Date
    
    init(id: UUID = UUID(), name: String, quantity: Int, creationDate: Date = Date()) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.creationDate = creationDate
        
        
    }
}


struct Note: Identifiable, Codable {
    let id: UUID
    var title: String
    var note: String?
    var linkedItemIDs: [UUID]
    var creationDate: Date
    
    init(id: UUID = UUID(), title: String, note: String? = nil, linkedItemIDs: [UUID] = [], creationDate: Date = Date()) {
        self.id = id
        self.title = title
        self.note = note
        self.linkedItemIDs = linkedItemIDs
        self.creationDate = creationDate
    }
}
