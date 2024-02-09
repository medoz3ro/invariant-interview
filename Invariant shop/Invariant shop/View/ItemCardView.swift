//
//  ItemCradView.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 05.02.2024..
//

import SwiftUI

struct ItemCardView: View {
    var item: Item

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(item.name)
                .textStyle()
            
            HStack {
                Text("Quantity:")
                Text("\(item.quantity)")
            }
            .textStyle(font: .subheadline)
            
            HStack {
                Spacer()
                Text("Created: \(dateFormatter.string(from: item.creationDate))")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .cardStyle()
    }
}



struct ItemCardView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample item to pass to the ItemCardView
        let sampleItem = Item(name: "Bread", quantity: 2, creationDate: Date())
        // Pass the sample item to the ItemCardView
        ItemCardView(item: sampleItem)
    }
}


