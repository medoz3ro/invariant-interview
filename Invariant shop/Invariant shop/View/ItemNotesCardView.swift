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
        VStack(alignment: .leading, spacing: 5) {
            Text(note.title)
                .font(.headline)
                .lineLimit(1) // Ensure title is limited to a single line
                .truncationMode(.tail) // Truncate at the end if needed
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text("Note:")
                // Display "Empty" if note.note is nil or empty, otherwise display note.note
                Text(note.note?.isEmpty ?? true ? "Empty" : note.note!)
            }
            .font(.subheadline)
            
            
            Spacer()
            
            HStack {
                Spacer()
                Text("Created: \(dateFormatter.string(from: note.creationDate))")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
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
        let sampleNote = Note(id: UUID(), title: "Sample Title", note: "Sample Note Content", linkedItemIDs: [], creationDate: Date())
        
        ItemCardNotesView(note: sampleNote)
    }
}
