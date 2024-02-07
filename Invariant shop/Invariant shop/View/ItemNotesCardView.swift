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
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 8) {
                Text(note.title) // Note: assuming title is not optional
                    .font(.headline)
                
                Text(note.note ?? "") // Safely unwrap the optional note and provide a default value if it's nil
                    .font(.subheadline)

                Text("Created: \(dateFormatter.string(from: note.creationDate))")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding() // Add padding if necessary
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
        }
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
        // Create a sample note for preview purposes
        let sampleNote = Note(id: UUID(), title: "Sample Title", note: "Sample Note Content", linkedItemIDs: [], creationDate: Date())
        
        // Preview ItemCardNotesView with the sample note
        ItemCardNotesView(note: sampleNote)
    }
}


