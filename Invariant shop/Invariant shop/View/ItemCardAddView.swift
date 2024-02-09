import SwiftUI

struct ItemCardAddView: View {
    @Environment(\.presentationMode) var presentationMode
    var addItem: (Item) -> Void
    @State private var itemName: String = ""
    @State private var itemQuantityString: String = ""
    @State private var showingDiscardAlert: Bool = false

    // Check if there have been any changes to enable the "Add" button
    var hasChanges: Bool {
        !itemName.isEmpty || !itemQuantityString.isEmpty
    }

    var isAddButtonDisabled: Bool {
        itemName.isEmpty || Double(itemQuantityString) == nil
    }

    private func addNewItem() {
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
                if hasChanges {
                    showingDiscardAlert = true
                } else {
                    presentationMode.wrappedValue.dismiss()
                }
            }, trailing: Button("Add") {
                addNewItem()
            }.disabled(isAddButtonDisabled))
            .alert(isPresented: $showingDiscardAlert) {
                Alert(
                    title: Text("Discard Changes?"),
                    message: Text("Are you sure you want to discard your changes?"),
                    primaryButton: .destructive(Text("Discard")) {
                        presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
}
