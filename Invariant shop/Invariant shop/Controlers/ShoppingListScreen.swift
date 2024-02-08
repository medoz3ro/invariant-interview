//
//  ShoppingListScreen.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 05.02.2024..
//

import SwiftUI

struct ShoppingListScreen: View {
    @ObservedObject var rootViewManager: RootViewManager
    @State private var items: [Item] = []
    @State private var selectedItem: Item?
    @State private var currentSort: SortType = .nameAscendingIdDescending 
    private let dataManager = DataManager()
    
    
    public init(rootViewManager: RootViewManager) {
            self.rootViewManager = rootViewManager
        }

    enum SortType {
        case nameAscendingIdDescending
        case nameDescendingIdAscending
    }




    private func loadItems() {
        items = dataManager.loadItems()
        sortItems() // Ensure items are sorted upon loading
    }

    private func addItem(_ item: Item) {
        items.append(item)
        dataManager.saveItems(items)
    }

    private func deleteItem(itemToDelete: Item) {
        if let index = items.firstIndex(where: { $0.id == itemToDelete.id }) {
            items.remove(at: index)
            dataManager.saveItems(items)
        }
        selectedItem = nil
    }

    // Function to handle saving edited items
    private func saveItem(_ updatedItem: Item) {
        if let index = items.firstIndex(where: { $0.id == updatedItem.id }) {
            items[index] = updatedItem
        } else {
            print("Item not found for update; this should not happen.")
        }
    }

    // Sorting function
    // Sorting function
    private func toggleSort() {
        switch currentSort {
        case .nameAscendingIdDescending:
            currentSort = .nameDescendingIdAscending
        case .nameDescendingIdAscending:
            currentSort = .nameAscendingIdDescending
        }
        sortItems() // Re-sort the items after changing the sort order
    }


    
    private func sortItems() {
        switch currentSort {
        case .nameAscendingIdDescending:
            items.sort {
                if $0.name.lowercased() == $1.name.lowercased() {
                    return $0.id.uuidString > $1.id.uuidString // For matching names, sort by ID descending
                }
                return $0.name.lowercased() < $1.name.lowercased() // Primary sort by name ascending
            }
        case .nameDescendingIdAscending:
            items.sort {
                if $0.name.lowercased() == $1.name.lowercased() {
                    return $0.id.uuidString < $1.id.uuidString // For matching names, sort by ID ascending
                }
                return $0.name.lowercased() > $1.name.lowercased() // Primary sort by name descending
            }
        }
    }




    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 10) {
                    TitleView(title: "Shopping List")
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
            NavigationShoppingView(items: $items, addItem: self.addItem, toggleSort: self.toggleSort, rootViewManager: rootViewManager)
                .frame(maxWidth: .infinity, maxHeight: 20, alignment: .bottom)
                .background(Color("Bottom").edgesIgnoringSafeArea(.bottom).opacity(0))
        }
        .onAppear(perform: {
            loadItems()
            currentSort = .nameAscendingIdDescending // Set the initial sort order correctly
            sortItems() // Apply initial sort
        })


        .sheet(item: $selectedItem) { selectedItem in
            ItemEditView(item: .constant(selectedItem), onDismiss: {
                self.selectedItem = nil
            }, onSave: { updatedItem in
                saveItem(updatedItem)
            }, onDelete: { itemToDelete in
                deleteItem(itemToDelete: itemToDelete) // Corrected function call
            })
        }
    }
}

// Assuming the existence of DataManager, Item, ItemEditView, NavigationView, TitleView, and ItemCardView
// Make sure you replace these placeholders with your actual implementations or references.




struct ShoppingListScreen_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of RootViewManager for preview purposes
        let rootViewManager = RootViewManager()
        
        // Pass the rootViewManager instance to ShoppingListScreen
        ShoppingListScreen(rootViewManager: rootViewManager)
    }
}

