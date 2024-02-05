//
//  ItemCard.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 05.02.2024..
//

import SwiftUI

import SwiftUI

struct ItemCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .frame(width: geometry.size.width * 0.95, height: 50.0)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color("Border"), lineWidth: 1)
                )
                .font(.system(size: 16))
                .foregroundColor(Color("Text"))
                .contentShape(Rectangle())
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
    }
}
