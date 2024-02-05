//
//  NavigationModifier.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 05.02.2024..
//

import SwiftUI

struct NavigationModifier: ViewModifier {
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content.alignmentGuide(.bottom) { _ in
                -geometry.size.height / 2
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}
