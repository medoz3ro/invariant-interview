//
//  ShoppingListScreen.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 05.02.2024..
//

import SwiftUI

struct ShoppingListScreen: View {
    @ObservedObject var rootViewManager: RootViewManager
    @State private var isAiChatViewPresented = false
    @State private var items: [Item] = []
    @State private var selectedItem: Item?
    @State private var currentSort: SortType = .nameAscendingIdDescending
    private let dataManager = DataManager()
    var chatController: ChatController

    
    
    public init(rootViewManager: RootViewManager, chatController: ChatController) {
        self.rootViewManager = rootViewManager
        self.chatController = chatController

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
            sortItems()
            dataManager.saveItems(items)
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
            VStack(spacing: 10) {
                VStack(spacing: 0) {
                    Color("Title")
                        .edgesIgnoringSafeArea(.top)
                    
                    TitleView(title: "Shopping List")
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 115, alignment: .top)
                
                
                ScrollView {
                    ForEach(items) { item in
                        ItemCardView(item: item)
                            .onTapGesture {
                                self.selectedItem = item
                            }
                    }
                    .padding()
                    
                }
            }
            
            
            
            
            NavigationShoppingView(items: $items, addItem: self.addItem, toggleSort: self.toggleSort, rootViewManager: rootViewManager)
                .frame(maxWidth: .infinity, maxHeight: 20, alignment: .bottom)
                .background(Color("Bottom").edgesIgnoringSafeArea(.bottom).opacity(0))
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        self.isAiChatViewPresented.toggle()
                    }) {
                        ZStack {
                            Circle()
                                .foregroundColor(Color("aibackground").opacity(0.5))
                                .frame(width: 50, height: 50)
                            Text("AI")
                                .foregroundColor(Color("Text"))
                                .font(.headline)
                        }
                        .padding(16)
                    }
                }
                .padding(.bottom, 20)
            }
            
            
        }
        .onAppear(perform: {
            loadItems()
            currentSort = .nameAscendingIdDescending
        })
        
        .sheet(isPresented: $isAiChatViewPresented) {
            AiChatView(chatController: chatController)
        }
        
        
        .sheet(item: $selectedItem) { selectedItem in
            ItemEditView(item: .constant(selectedItem), onDismiss: {
                self.selectedItem = nil
            }, onSave: { updatedItem in
                saveItem(updatedItem)
            }, onDelete: { itemToDelete in
                deleteItem(itemToDelete: itemToDelete)
            })
        }
        .edgesIgnoringSafeArea(.top)
        
    }
}


struct ShoppingListScreen_Previews: PreviewProvider {
    static var previews: some View {
        let openAIService = OpenAIService(apiKey: "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")
        let chatController = ChatController(openAIService: openAIService)
        ShoppingListScreen(rootViewManager: RootViewManager(), chatController: chatController)
    }
}

