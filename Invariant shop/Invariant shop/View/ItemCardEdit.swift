import SwiftUI

struct ItemEditView: View {
    @Binding var item: Item? // Optional item
    var onDismiss: () -> Void
    var onSave: (Item) -> Void
    var onDelete: (Item) -> Void

    @State private var itemName: String = ""
    @State private var itemQuantity: Int = 0
    @State private var showingDeleteAlert = false

    var body: some View {
        SwiftUI.NavigationView {
            ZStack {
                // Main content
                VStack(spacing: 0) {
                    Form {
                        TextField("Item Name", text: $itemName)
                        TextField("Quantity", value: $itemQuantity, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                    }
                    Spacer() // This spacer does nothing in a VStack without a bottom view.
                }

                // Delete button positioned at the bottom
                VStack {
                    Spacer() // Pushes everything below to the bottom
                    if item != nil {
                        Button("Delete") {
                            showingDeleteAlert = true
                        }
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                }
            }
            .navigationTitle(item != nil ? "Edit Item" : "Add Item")
            .navigationBarItems(leading: Button("Cancel") {
                onDismiss()
            }, trailing: Button("Save") {
                let editingItem = Item(name: itemName, quantity: itemQuantity)
                onSave(editingItem)
            })
            .alert(isPresented: $showingDeleteAlert) {
                Alert(
                    title: Text("Confirm Delete"),
                    message: Text("Are you sure you want to delete this item?"),
                    primaryButton: .destructive(Text("Delete")) {
                        if let item = item {
                            onDelete(item)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
            .onAppear {
                if let item = item {
                    itemName = item.name
                    itemQuantity = item.quantity
                }
            }
        }
    }
}
