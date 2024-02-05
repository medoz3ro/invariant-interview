//
//  ItemCradView.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 05.02.2024..
//

import SwiftUI

struct ItemCardView: View {
    // State to control the visibility of the sheet
    @State private var isSheetPresented = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Kruh")
            HStack {
                Text("Količina: ")
                Text("12")
            }
        }
        .modifier(ItemCardModifier())
        .onTapGesture {
            // Present the sheet when the card is tapped
            self.isSheetPresented = true
        }
        .sheet(isPresented: $isSheetPresented) {
            // Content of the new window
            ItemCardEdit()
        }
    }
}
