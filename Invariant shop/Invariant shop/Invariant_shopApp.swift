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
    
    var body: some Scene {
        WindowGroup {
            switch rootViewManager.currentView {
            case .shoppingList:
                ShoppingListScreen(rootViewManager: rootViewManager)
            case .notesList:
                NotesListScreen(rootViewManager: rootViewManager)
            }
        }
    }
}


