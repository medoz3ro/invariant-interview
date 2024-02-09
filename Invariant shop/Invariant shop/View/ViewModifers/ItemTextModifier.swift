//
//  ItemTextModifier.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 09.02.2024..
//

import SwiftUI

struct ItemTextModifier: ViewModifier {
    var font: Font = .headline // Default font is .headline, but can be changed to .subheadline or any other font

    func body(content: Content) -> some View {
        content
            .font(font)
            .lineLimit(1)
            .truncationMode(.tail)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension View {
    // Function to easily apply the modifier with an optional font parameter
    func textStyle(font: Font = .headline) -> some View {
        self.modifier(ItemTextModifier(font: font))
    }
}

