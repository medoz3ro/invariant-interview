//
//  ItemNotesCardView.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 07.02.2024..
//

import SwiftUI

import SwiftUI

struct ItemCardNotesView: View {
    var note: Note

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(note.title)
                .font(.headline) // Uses headline font for the title

            HStack {
                Text("Note:")
                Text(note.note?.isEmpty ?? true ? "Empty" : note.note!)
                    .font(.subheadline) // Subheadline font for note content
            }

            HStack {
                Text("Linked Items:")
                Text("\(note.linkedItemIDs.count)")
                    .font(.subheadline) // Subheadline font for linked items count
            }

            Spacer()

            HStack {
                Spacer()
                Text("Created: \(dateFormatter.string(from: note.creationDate))")
                    .font(.caption)
                    .foregroundColor(.gray) // Gray color for the creation date
            }
        }
        .padding() // Adds padding inside the card
        .background(Color.white) // Sets the card's background color to white
        .cornerRadius(10) // Rounds the corners of the card
        .shadow(radius: 5) // Adds a shadow for a slight depth effect
    }
}

struct ItemCardNotesView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleNote = Note(id: UUID(), title: "Sample Title", note: "Sample Note Content", linkedItemIDs: [], creationDate: Date())

        ItemCardNotesView(note: sampleNote)
            .previewLayout(.sizeThatFits) // Adjusts the preview to fit the content
    }
}
