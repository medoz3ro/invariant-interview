//
//  Invariant_shopApp.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 05.02.2024..
//

import SwiftUI


class RootViewManager: ObservableObject {
    @Published var currentView: ViewType = .shoppingList
    
    enum ViewType {
        case shoppingList
        case notesList
    }
}


@main
struct Invariant_shopApp: App {
    @StateObject private var rootViewManager = RootViewManager()
    
    let openAIService = OpenAIService(apiKey: "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")
    var chatController: ChatController?

    init() {
        chatController = ChatController(openAIService: openAIService)
    }

    var body: some Scene {
        WindowGroup {
            switch rootViewManager.currentView {
            case .shoppingList:
                ShoppingListScreen(rootViewManager: rootViewManager, chatController: chatController!)
            case .notesList:
                NotesListScreen(rootViewManager: rootViewManager, chatController: chatController!)
            }
        }
    }
}

