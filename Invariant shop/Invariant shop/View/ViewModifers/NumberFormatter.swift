//
//  NumberFormatter.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 09.02.2024..
//

import Foundation

extension NumberFormatter {
    static var customAmountFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 3 // Maximum number of digits after the decimal
        formatter.minimumFractionDigits = 0 // Minimum number of digits after the decimal - this removes trailing zeros
        formatter.roundingMode = .halfUp // Defines how numbers are rounded
        return formatter
    }
}

