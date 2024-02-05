//
//  ShoppingListScreen.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 05.02.2024..
//

import SwiftUI

struct ShoppingListScreen: View {
    var body: some View {
        TitleView()
        ItemCardView()
        NavigationView()
    }
}

#Preview {
    ShoppingListScreen()
}
