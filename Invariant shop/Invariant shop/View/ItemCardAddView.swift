//
//  ItemCardAdd.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 06.02.2024..
//

import SwiftUI

struct ItemCardAddView: View {
    @Environment(\.presentationMode) var presentationMode
    var addItem: (Item) -> Void
    @State private var itemName: String = ""
    @State private var itemQuantity: String = ""

    var isAddButtonDisabled: Bool {
        itemName.isEmpty || itemQuantity.isEmpty || Int(itemQuantity) == nil
    }

    var body: some View {
        SwiftUI.NavigationView {
            Form {
                TextField("Item Name", text: $itemName)
                TextField("Quantity", text: $itemQuantity)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("Add Item")
            .navigationBarItems(leading: Button("Back") {
                if itemName.isEmpty && itemQuantity.isEmpty {
                    presentationMode.wrappedValue.dismiss()
                } else {
                    // Implement your logic for discard confirmation if needed
                    presentationMode.wrappedValue.dismiss()
                }
            }, trailing: Button("Add") {
                addNewItem()
            }.disabled(isAddButtonDisabled))
        }
    }

    private func addNewItem() {
        if let quantity = Int(itemQuantity), !itemName.isEmpty {
            let newItem = Item(name: itemName, quantity: quantity)
            addItem(newItem)
            presentationMode.wrappedValue.dismiss()
        }
    }
}




