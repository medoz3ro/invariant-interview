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
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                VStack {
                    Image("sort").resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
                .padding(.top, 20)
                
                Spacer()
                
                Button(action: { showingAddItemView = true }) {
                                    VStack {
                                        Image(systemName: "plus") // Changed for example
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 24, height: 24)
                                    }
                                    .padding(.top, 20)
                                }
                                .sheet(isPresented: $showingAddItemView) {
                                    ItemCardAddView(addItem: addItem) // Pass the closure to the add view
                                }
                                
                                Spacer()
                
                VStack {
                    Image("notes").resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
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
        NavigationView(items: .constant([]), addItem: { _ in }) // Provide a dummy closure for previews
    }
}




