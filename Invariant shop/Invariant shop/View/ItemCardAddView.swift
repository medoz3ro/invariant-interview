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
                    .onChange(of: itemQuantityString) { newValue in
                        let correctedValue = newValue.replacingOccurrences(of: ",", with: ".")
                        if correctedValue != newValue {
                            itemQuantityString = correctedValue
                        } else {
                            // The rest of your validation or formatting logic
                            let filtered = correctedValue.filter { "0123456789.".contains($0) }
                            if filtered.filter({ $0 == "." }).count <= 1 {
                                itemQuantityString = filtered // Only digits and at most one decimal point
                            } else {
                                // Handle multiple dots if necessary
                                itemQuantityString = String(filtered.prefix(while: { $0 != "." })) + filtered.split(separator: ".").prefix(2).joined(separator: ".")
                            }
                        }
                    }
                
                
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
