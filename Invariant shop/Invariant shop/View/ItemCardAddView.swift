import SwiftUI

struct ItemCardAddView: View {
    @Environment(\.presentationMode) var presentationMode
    var addItem: (Item) -> Void
    @State private var itemName: String = ""
    @State private var itemQuantityString: String = ""

    // Dynamically calculate `isAddButtonDisabled` based on itemName and itemQuantityString
    var isAddButtonDisabled: Bool {
        itemName.isEmpty || Double(itemQuantityString) == nil
    }

    private func addNewItem() {
        // Directly check and use `itemQuantityString` to create a new item
        if let quantity = Double(itemQuantityString), !itemName.isEmpty {
            let newItem = Item(name: itemName, quantity: quantity)
            addItem(newItem)
            presentationMode.wrappedValue.dismiss()
        }
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Item Name", text: $itemName)
                TextField("Quantity", text: $itemQuantityString)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add Item")
            .navigationBarItems(leading: Button("Back") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Add") {
                addNewItem()
            }.disabled(isAddButtonDisabled))
        }
    }
}
