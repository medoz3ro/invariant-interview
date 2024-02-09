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
    
    
    private func loadItems() {
        items = dataManager.loadItems()
        sortItems()
    }
    
    
    enum SortType {
        case nameAscendingIdDescending
        case nameDescendingIdAscending
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
    
    
    private func saveItem(_ updatedItem: Item) {
        if let index = items.firstIndex(where: { $0.id == updatedItem.id }) {
            items[index] = updatedItem
        } else {
            print("Item not found for update; this should not happen.")
        }
    }
    
    
    private func toggleSort() {
        switch currentSort {
        case .nameAscendingIdDescending:
            currentSort = .nameDescendingIdAscending
        case .nameDescendingIdAscending:
            currentSort = .nameAscendingIdDescending
        }
        sortItems()
    }
    
    
    
    private func sortItems() {
        switch currentSort {
        case .nameAscendingIdDescending:
            items.sort {
                if $0.name.lowercased() == $1.name.lowercased() {
                    return $0.id.uuidString > $1.id.uuidString
                }
                return $0.name.lowercased() < $1.name.lowercased()
            }
        case .nameDescendingIdAscending:
            items.sort {
                if $0.name.lowercased() == $1.name.lowercased() {
                    return $0.id.uuidString < $1.id.uuidString
                }
                return $0.name.lowercased() > $1.name.lowercased()
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
            currentSort = .nameAscendingIdDescending
        })
        
        
        .sheet(item: $selectedItem) { selectedItem in
            ItemEditView(item: .constant(selectedItem), onDismiss: {
                self.selectedItem = nil
            }, onSave: { updatedItem in
                saveItem(updatedItem)
            }, onDelete: { itemToDelete in
                deleteItem(itemToDelete: itemToDelete)
            })
        }
    }
}


struct ShoppingListScreen_Previews: PreviewProvider {
    static var previews: some View {
        let rootViewManager = RootViewManager()
        
        ShoppingListScreen(rootViewManager: rootViewManager)
    }
}

