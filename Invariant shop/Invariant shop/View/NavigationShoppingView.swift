//
//  NavigationView.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 05.02.2024..
//

import SwiftUI


struct NavigationShoppingView: View {
    @Binding var items: [Item]
    var addItem: (Item) -> Void
    var toggleSort: () -> Void
    var rootViewManager: RootViewManager
    
    
    @State private var showingAddItemView = false
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: toggleSort) {
                    Image(systemName: "arrow.up.arrow.down")
                        .navigationImageStyle()
                }
                Spacer()
                Button(action: { showingAddItemView = true }) {
                    Image(systemName: "plus")
                        .navigationImageStyle()
                }
                .sheet(isPresented: $showingAddItemView) {
                    ItemCardAddView(addItem: addItem)
                }
                Spacer()
                Button(action: {
                    rootViewManager.currentView = .notesList 
                }) {
                    Image("notes")
                        .navigationImageStyle()
                }
                Spacer()
            }
            .padding(.vertical)
            .frame(height: 40)
        }
        .background(Color("Bottom"))
    }
}





struct NavigationShoppingView_Previews: PreviewProvider {
    static var previews: some View {
        let rootViewManager = RootViewManager()
        
        NavigationShoppingView(items: .constant([]), addItem: { _ in }, toggleSort: { }, rootViewManager: rootViewManager)
        
        
    }
}


