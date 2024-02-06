import SwiftUI

import SwiftUI

struct ItemEditView: View {
    @Binding var item: Item? // Optional item
    var onDismiss: () -> Void
    var onDelete: (Item) -> Void

    // Temporary state for editing
    @State private var itemName: String = ""
    @State private var itemQuantity: Int = 0

    var body: some View {
        VStack {
            // Bind text fields to temporary states
            TextField("Item Name", text: $itemName)
            TextField("Quantity", value: $itemQuantity, formatter: NumberFormatter())
                .keyboardType(.numberPad)

            Button("Delete") {
                if let item = item {
                    onDelete(item)
                }
            }
            .foregroundColor(.red)

            Spacer()
        }
        .onAppear { // Correct placement of .onAppear
            if let item = item {
                itemName = item.name
                itemQuantity = item.quantity
            }
        }
        .navigationBarItems(trailing: Button("Done") {
            // Update the item before dismissing if it's not nil
            if var editingItem = item {
                editingItem.name = itemName
                editingItem.quantity = itemQuantity
                item = editingItem // Update the binding
            }
            onDismiss()
        })
    }
}
