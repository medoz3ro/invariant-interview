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
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
                .padding(.top, 20)
                Spacer()
                Button(action: { showingAddItemView = true }) {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding(.top, 20)
                }
                .sheet(isPresented: $showingAddItemView) {
                    ItemCardAddView(addItem: addItem)
                }
                Spacer()
                Button(action: {
                    rootViewManager.currentView = .notesList // Update this line
                }) {
                    Image("notes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding(.top, 20)
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
        // Create an instance of RootViewManager for preview purposes
        let rootViewManager = RootViewManager()
        
        NavigationShoppingView(items: .constant([]), addItem: { _ in }, toggleSort: { }, rootViewManager: rootViewManager)
        
        
    }
}


