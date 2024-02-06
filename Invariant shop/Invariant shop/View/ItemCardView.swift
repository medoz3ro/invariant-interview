//
//  ItemCradView.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 05.02.2024..
//

import SwiftUI

struct ItemCardView: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Kruh")
            HStack {
                Text("Količina: ")
                Text("12")
            }
        }
        .modifier(ItemCardModifier())
    }
}

#Preview {
    ItemCardView()
}
