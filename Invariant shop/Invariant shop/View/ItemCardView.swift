//
//  ItemCradView.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 05.02.2024..
//

import SwiftUI

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
        VStack(alignment: .leading, spacing: 8) {
            Text(item.name)
                .font(.headline)
            
            HStack {
                Text("Quantity:")
                Text("\(item.quantity)")
            }
            .font(.subheadline)
            
            Text("Created: \(dateFormatter.string(from: item.creationDate))")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}



struct ItemCardView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample item to pass to the ItemCardView
        let sampleItem = Item(name: "Bread", quantity: 2, creationDate: Date())
        // Pass the sample item to the ItemCardView
        ItemCardView(item: sampleItem)
            .previewLayout(.sizeThatFits)
    }
}


