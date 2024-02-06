import SwiftUI

struct ItemEditView: View {
    @Binding var item: Item? // Optional item
    var onDismiss: () -> Void
    var onSave: (Item) -> Void // Closure to handle save action
    var onDelete: (Item) -> Void

    // Temporary state for editing
    @State private var itemName: String = ""
    @State private var itemQuantity: Int = 0

    var body: some View {
        SwiftUI.NavigationView {
            VStack {
                TextField("Item Name", text: $itemName)
                    .padding()
                TextField("Quantity", value: $itemQuantity, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                    .padding()

                Button("Delete") {
                    if let item = item {
                        onDelete(item)
                    }
                }
                .foregroundColor(.red)
                .padding()

                Spacer()
            }
            .navigationTitle("Edit Item")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        onDismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if var editingItem = item {
                            editingItem.name = itemName
                            editingItem.quantity = itemQuantity
                            onSave(editingItem) // Call the onSave closure with the updated item
                        }
                    }
                }
            }
            .onAppear { // Initialize temporary states when the view appears
                if let item = item {
                    itemName = item.name
                    itemQuantity = item.quantity
                }
            }
        }
    }
}
