//
//  DataManager.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 06.02.2024..
//

import Foundation

class DataManager {
    private let itemsKey = "items"

    func saveItems(_ items: [Item]) {
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(items)
            UserDefaults.standard.set(encoded, forKey: itemsKey)
        } catch {
            print("Failed to encode items: \(error)")
        }
    }

    func loadItems() -> [Item] {
        guard let itemsData = UserDefaults.standard.data(forKey: itemsKey) else {
            print("No items found")
            return []
        }

        let decoder = JSONDecoder()
        do {
            let items = try decoder.decode([Item].self, from: itemsData)
            return items
        } catch {
            print("Failed to decode items: \(error)")
            return []
        }
    }
}

