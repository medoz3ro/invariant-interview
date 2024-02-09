import SwiftUI

struct ItemEditView: View {
    @Binding var item: Item?
    var onDismiss: () -> Void
    var onSave: (Item) -> Void
    var onDelete: (Item) -> Void
    
    @State private var itemName: String = ""
    @State private var itemQuantity: Int = 0
    @State private var activeAlert: ActiveAlert?
    
    
    enum ActiveAlert: Identifiable {
        case discardChanges, confirmDelete
        
        var id: Int {
            self.hashValue
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Form {
                    TextField("Item Name", text: $itemName)
                    TextField("Quantity", value: $itemQuantity, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                    
                    
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
                    itemQuantity = item.quantity
                }
            }
        }
    }
    
    private func hasChanges() -> Bool {
        guard let initialItem = item else {
            return !(itemName.isEmpty && itemQuantity == 0)
        }
        return initialItem.name != itemName || initialItem.quantity != itemQuantity
    }
    
    private func saveItem() {
        if let existingItem = item {
            let updatedItem = Item(id: existingItem.id, name: itemName, quantity: itemQuantity, creationDate: existingItem.creationDate)
            onSave(updatedItem)
        } else {
            let newItem = Item(name: itemName, quantity: itemQuantity)
            onSave(newItem)
        }
        onDismiss()
    }
}
