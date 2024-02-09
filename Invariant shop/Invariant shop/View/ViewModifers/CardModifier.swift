//
//  CardModifier.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 09.02.2024..
//

import SwiftUI

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color("Text"))
            .cornerRadius(10)
            .shadow(radius: 2)
            .frame(maxWidth: .infinity)
    }
}

extension View {
    func cardStyle() -> some View {
        self.modifier(CardModifier())
    }
}
