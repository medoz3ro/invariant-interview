//
//  TitleTextModifier.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 09.02.2024..
//


import SwiftUI

struct TitleTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(Color(.white))
    }
}

extension View {
    func TitleModifier() -> some View {
        self.modifier(TitleTextModifier())
    }
}
