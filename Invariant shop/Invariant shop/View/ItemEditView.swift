import SwiftUI

struct ItemEditView: View {
    @Binding var item: Item?
    var onDismiss: () -> Void
    var onSave: (Item) -> Void
    var onDelete: (Item) -> Void
    
    @State private var itemName: String = ""
    @State private var itemQuantityString: String = "" // Changed to String to manually handle input
    @State private var activeAlert: ActiveAlert?
    
    enum ActiveAlert: Identifiable {
        case discardChanges, confirmDelete
        
        var id: Int {
            self.hashValue
        }
    }
    
    private func hasChanges() -> Bool {
        guard let initialItem = item else {
            return !(itemName.isEmpty && itemQuantityString.isEmpty)
        }
        return initialItem.name != itemName || initialItem.quantity != Double(itemQuantityString)
    }
    
    private func saveItem() {
        guard let quantity = Double(itemQuantityString), !itemName.isEmpty else { return } // Ensure valid conversion
        
        if let existingItem = item {
            let updatedItem = Item(id: existingItem.id, name: itemName, quantity: quantity, creationDate: existingItem.creationDate)
            onSave(updatedItem)
        } else {
            let newItem = Item(name: itemName, quantity: quantity)
            onSave(newItem)
        }
        onDismiss()
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Form {
                    TextField("Item Name", text: $itemName)
                    TextField("Quantity", text: $itemQuantityString)
                        .keyboardType(.decimalPad)
                        .onChange(of: itemQuantityString) { newValue in
                            let filtered = newValue.filter { "0123456789.".contains($0) }
                            if filtered == newValue, filtered.filter({ $0 == "." }).count <= 1 {
                                itemQuantityString = filtered // Valid input: only digits and max one decimal point
                            } else {
                                itemQuantityString = String(filtered.prefix(while: { $0 != "." })) + filtered.split(separator: ".").prefix(2).joined(separator: ".")
                            }
                        }

                    Section {
                        if item != nil {
                            Button("Delete Item", role: .destructive) {
                                activeAlert = .confirmDelete
                            }
                        }
                    }
                }
            }
            .navigationTitle(item != nil ? "Edit Item" : "Add Item")
            .navigationBarItems(leading: Button("Cancel") {
                if hasChanges() {
                    activeAlert = .discardChanges
                } else {
                    onDismiss()
                }
            }, trailing: Button("Save") {
                saveItem()
            })
            .alert(item: $activeAlert) { alertType in
                switch alertType {
                case .discardChanges:
                    return Alert(
                        title: Text("Discard Changes?"),
                        message: Text("Are you sure you want to discard your changes?"),
                        primaryButton: .destructive(Text("Discard")) {
                            onDismiss()
                        },
                        secondaryButton: .cancel()
                    )
                case .confirmDelete:
                    return Alert(
                        title: Text("Confirm Delete"),
                        message: Text("Are you sure you want to delete this item?"),
                        primaryButton: .destructive(Text("Delete")) {
                            if let item = item {
                                onDelete(item)
                            }
                            onDismiss()
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .onAppear {
                if let item = item {
                    itemName = item.name
                    itemQuantityString = "\(item.quantity)"
                }
            }
        }
    }
}
