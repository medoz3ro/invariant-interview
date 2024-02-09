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
    var addNote: (Note) -> Void
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                       self.onSort()
                   }) {
                       Image(systemName: "arrow.up.arrow.down")
                           .navigationImageStyle()
                   }
                
                
                Spacer()
                Button(action: {
                    showingAddNotesView = true
                }) {
                    Image(systemName: "plus")
                        .navigationImageStyle()
                   
                }
                .sheet(isPresented: $showingAddNotesView) {
                    AddNotesView(addNote: addNote)
                }
                
                Spacer()
                Button(action: {
                    rootViewManager.currentView = .shoppingList
                }) {
                    Image(systemName: "list.bullet")
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


struct NavigationNotesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationNotesView(rootViewManager: RootViewManager(), onSort: {}, addNote: {_ in })

    }
}


