//
//  NavigationView.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 06.02.2024..
//

import SwiftUI

struct NavigationNotesView: View {
    @State private var showingAddNotesView = false
    var rootViewManager: RootViewManager
    
    var onSort: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                // Image for sorting or any other action
                Button(action: {
                       self.onSort() // Call the sorting closure
                   }) {
                       Image(systemName: "arrow.up.arrow.down")
                           .resizable()
                           .scaledToFit()
                           .frame(width: 24, height: 24)
                           .padding(.top, 20)
                           
                   }
                Spacer()
                // Plus button to add notes
                Button(action: {
                    showingAddNotesView = true
                }) {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding(.top, 20)
                   
                }
                .sheet(isPresented: $showingAddNotesView) {
                    // Present AddNotesView and provide the addNote closure
                    AddNotesView(addNote: { _ in
                        // Placeholder implementation for adding a note
                        print("Note added")
                    })
                }
                Spacer()
                // Image for listing or any other action
                // In NavigationNotesView, adjust the button action to update RootViewManager
                Button(action: {
                    rootViewManager.currentView = .shoppingList // Assuming you want to switch view
                }) {
                    Image(systemName: "list.bullet")
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


struct NavigationNotesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationNotesView(rootViewManager: RootViewManager(), onSort: {})

    }
}


