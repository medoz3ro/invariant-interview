//
//  ItemNotesCardView.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 07.02.2024..
//

import SwiftUI

struct ItemCardNotesView: View {
    var note: Note

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(note.title)
                .font(.headline)
                .foregroundColor(.black) // Ensure text color matches

            Text(note.note)
                .font(.subheadline)
                .foregroundColor(.secondary) // Ensure this matches the style in ItemCardView

            Text("Created: \(dateFormatter.string(from: note.creationDateNote))")
                .font(.caption)
                .foregroundColor(.gray) // Match the font and color
        }
        .padding()
        .background(Color.white) // Match background color
        .cornerRadius(10) // Match corner radius
        .shadow(radius: 2) // Match shadow appearance
        .padding(.horizontal) // Ensure consistent padding
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}

struct ItemCardNotesView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample note to pass to the ItemCardNotesView
        let sampleNote = Note(id: UUID(), title: "Sample Note", note: "This is a sample note.", creationDateNote: Date())
        // Pass the sample note to the ItemCardNotesView
        ItemCardNotesView(note: sampleNote)
            .previewLayout(.sizeThatFits)
    }
}



