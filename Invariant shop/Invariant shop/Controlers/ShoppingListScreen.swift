//
//  ShoppingListScreen.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 05.02.2024..
//

import SwiftUI

struct ShoppingListScreen: View {
    @State private var items: [Item] = []
    @State private var selectedItem: Item? // Track selected item
    private let dataManager = DataManager()

    // Load items from UserDefaults
    private func loadItems() {
        items = dataManager.loadItems()
    }

    // Function to handle adding a new item
    private func addItem(_ item: Item) {
        items.append(item)
        dataManager.saveItems(items)
    }

    // Update for deleteItem function to save changes
    private func deleteItem(itemToDelete: Item) {
        if let index = items.firstIndex(where: { $0.id == itemToDelete.id }) {
            items.remove(at: index)
            dataManager.saveItems(items)
            selectedItem = nil // Reset selected item to avoid accessing it after deletion
        }
    }

    // Function to handle saving item changes
    private func saveItem(updatedItem: Item) {
        if let index = items.firstIndex(where: { $0.id == updatedItem.id }) {
            items[index] = updatedItem // Update the item in the array
            dataManager.saveItems(items) // Save the updated items array to persist the changes
        }
        selectedItem = nil // Optionally reset selected item
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 10) {
                    TitleView()
                        .frame(maxWidth: .infinity, alignment: .top)

                    ForEach(items) { item in
                        ItemCardView(item: item)
                            .onTapGesture {
                                self.selectedItem = item
                            }
                    }

                    Spacer().frame(height: 70)
                }
            }
            NavigationView(items: $items, addItem: addItem)
                .frame(maxWidth: .infinity, maxHeight: 20, alignment: .bottom)
                .background(Color("Bottom").edgesIgnoringSafeArea(.bottom).opacity(0))
        }
        .onAppear(perform: loadItems)
        .sheet(item: $selectedItem) { _ in
            ItemEditView(item: $selectedItem, onDismiss: {
                self.selectedItem = nil // Reset the selectedItem when done
            }, onSave: saveItem, onDelete: deleteItem)
        }
    }
}



#Preview {
    ShoppingListScreen()
}
