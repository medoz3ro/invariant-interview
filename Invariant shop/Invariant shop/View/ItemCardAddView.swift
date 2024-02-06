//
//  ItemCardAdd.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 06.02.2024..
//

import SwiftUI

struct ItemCardAddView: View {
    var addItem: (Item) -> Void
    @State private var itemName: String = ""
    @State private var itemQuantity: String = ""

    var body: some View {
        Form {
            TextField("Item Name", text: $itemName)
            TextField("Quantity", text: $itemQuantity)
                .keyboardType(.numberPad)

            Button("Add") {
                if let quantity = Int(itemQuantity), !itemName.isEmpty {
                    let newItem = Item(name: itemName, quantity: quantity)
                    addItem(newItem) // Use the closure to add an item
                    // Reset fields for the next entry
                    itemName = ""
                    itemQuantity = ""
                }
            }
        }
        .navigationTitle("Add Item")
    }
}



