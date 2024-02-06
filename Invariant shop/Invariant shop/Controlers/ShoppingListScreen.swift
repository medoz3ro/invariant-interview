//
//  ShoppingListScreen.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 05.02.2024..
//

import SwiftUI

struct ShoppingListScreen: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 10) {
                    TitleView()
                        .frame(maxWidth: .infinity, alignment: .top)

                    ForEach(0..<20) { _ in
                        ItemCardView()
                    }

                    Spacer().frame(height: 70)
                }
            }

            NavigationView()
                .frame(maxWidth: .infinity, maxHeight: 20, alignment: .bottom)
                .background(Color("Bottom").edgesIgnoringSafeArea(.bottom).opacity(0))
               
        }
    }
}

#Preview {
    ShoppingListScreen()
}
