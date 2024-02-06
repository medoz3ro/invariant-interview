//
//  ItemCard.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 05.02.2024..
//

import SwiftUI

struct ItemCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: UIScreen.main.bounds.width * 0.9, maxHeight: 50)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.white)
                    .shadow(color: .gray, radius: 5, x: 2, y: 2)
            )
            .font(.system(size: 16))
            .foregroundColor(Color("Text"))
            .contentShape(RoundedRectangle(cornerRadius: 14))
    }
}

