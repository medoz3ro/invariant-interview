//
//  ChatControler.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 17.02.2024..
//

import OpenAISwift
import Foundation

final class ChatController {
    static let shared = ChatController()
    
    private init() {}
    
    func processInput(_ input: String) {
        // A very simple pattern matching for demonstration
        // This should be replaced with more sophisticated NLP for production use
        if input.contains("kupiti u") {
            // Assume the input is related to a store or a note
            let noteTitle = input.components(separatedBy: "kupiti u").last?.trimmingCharacters(in: .whitespaces) ?? ""
            let note = Note(title: noteTitle, note: input)
            DataManager.shared.saveNote(note)
        } else {
            // Parse for item and quantity
            let components = input.components(separatedBy: " ")
            if components.count >= 3, let quantity = Double(components[0]) {
                let itemName = components.dropFirst().joined(separator: " ")
                let item = Item(name: itemName, quantity: quantity)
                DataManager.shared.saveItems([item])
            }
        }
    }
}


//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
