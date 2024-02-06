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

