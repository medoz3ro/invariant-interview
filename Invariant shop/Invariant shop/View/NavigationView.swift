//
//  NavigationView.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 05.02.2024..
//

import SwiftUI


struct NavigationView: View {
    @State private var showingAddItemView = false
    @Binding var items: [Item]
    var addItem: (Item) -> Void
    var toggleSort: () -> Void // Added this

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: toggleSort) {
                    Image(systemName: "arrow.up.arrow.down") // Example icon for sorting
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
                Image("notes").resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding(.top, 20)
                Spacer()
            }
            .padding(.vertical)
            .frame(height: 40)
        }
        .background(Color.white)
        .shadow(color: .gray, radius: 1)
    }
}



struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView(items: .constant([]), addItem: { _ in }, toggleSort: {
            // Dummy closure for preview purposes
        })
    }
}




