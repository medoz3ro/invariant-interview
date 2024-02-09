//
//  ItemNotesCardView.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 07.02.2024..
//

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
                .textStyle()
            
            HStack {
                Text("Note:")
                Text(note.note?.isEmpty ?? true ? "Empty" : note.note!)
            }
            .textStyle(font: .subheadline)
            
            
            Spacer()
            
            HStack {
                Spacer()
                Text("Created: \(dateFormatter.string(from: note.creationDate))")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .cardStyle()
    }
}

struct ItemCardNotesView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleNote = Note(id: UUID(), title: "Sample Title", note: "Sample Note Content", linkedItemIDs: [], creationDate: Date())
        
        ItemCardNotesView(note: sampleNote)
    }
}
