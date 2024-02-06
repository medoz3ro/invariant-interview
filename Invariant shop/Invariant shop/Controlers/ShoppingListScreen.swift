//
//  ShoppingListScreen.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 05.02.2024..
//

import SwiftUI

struct ShoppingListScreen: View {
    @State private var items: [Item] = []
    @State private var selectedItem: Item?
    @State private var currentSort: SortType = .none
    private let dataManager = DataManager()

    enum SortType {
        case nameAscending, idDescending, none
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

    private func saveItem(updatedItem: Item) {
        if let index = items.firstIndex(where: { $0.id == updatedItem.id }) {
            items[index] = updatedItem
            dataManager.saveItems(items)
        }
        selectedItem = nil
    }

    // Sorting function
    private func toggleSort() {
        switch currentSort {
        case .none, .idDescending:
            currentSort = .nameAscending
            items.sort { $0.name < $1.name }
        case .nameAscending:
            currentSort = .idDescending
            items.sort { $0.id > $1.id }
        }
        dataManager.saveItems(items) // Optionally save the sorted list
        // Display a subtle message here indicating the current sort type
    }
    
    private func sortItems() {
        switch currentSort {
        case .nameAscending:
            items.sort { $0.name.lowercased() < $1.name.lowercased() }
        case .idDescending:
            items.sort { $0.id > $1.id }
        case .none:
            break // No sorting applied, or you can reset to the original order if needed
        }
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
            NavigationView(items: $items, addItem: addItem, toggleSort: toggleSort) // Pass toggleSort function
                .frame(maxWidth: .infinity, maxHeight: 20, alignment: .bottom)
                .background(Color("Bottom").edgesIgnoringSafeArea(.bottom).opacity(0))
        }
        .onAppear(perform: loadItems)
        .sheet(item: $selectedItem) { _ in
            ItemEditView(item: $selectedItem, onDismiss: {
                self.selectedItem = nil
            }, onSave: saveItem, onDelete: deleteItem)
        }
    }
}



#Preview {
    ShoppingListScreen()
}
