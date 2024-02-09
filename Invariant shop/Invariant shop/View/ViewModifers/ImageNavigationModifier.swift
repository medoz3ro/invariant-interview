//
//  ImageNavigationModifier.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 09.02.2024..
//

import SwiftUI

extension Image {
    func navigationImageStyle() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
            .padding(.top, 20)
    }
}
