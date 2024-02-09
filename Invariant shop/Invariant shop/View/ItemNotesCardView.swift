import SwiftUI

struct ItemCardNotesView: View {
    let note: Note
    @State private var isNoteDetailsPresented = false

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(note.title)
                    .font(.headline)
                Spacer()
                Button(action: {
                    // This action toggles the presentation of the NoteDetailsView.
                    isNoteDetailsPresented = true
                }) {
                    Image(systemName: "info") // Eye icon for viewing details.
                        .foregroundColor(.blue)
                }
                .sheet(isPresented: $isNoteDetailsPresented) {
                    // Present NoteDetailsView modally when isNoteDetailsPresented is true.
                    NoteDetailsView(note: note)
                }
            }

            // Display a preview of the note content.
            if let noteContent = note.note {
                Text(noteContent)
                    .font(.subheadline)
                    .lineLimit(1) // Limit to a single line to keep the UI tidy.
            } else {
                Text("No additional content")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            // Show the number of linked items.
            Text("Items linked: \(note.linkedItemIDs.count)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white) // Use a white background for the card.
        .cornerRadius(10) // Rounded corners for the card.
        .shadow(radius: 5) // Apply a shadow for depth.
    }
}

// MARK: - Previews
struct ItemCardNotesView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide a sample note for the preview.
        let sampleNote = Note(id: UUID(),
                              title: "Sample Note Title",
                              note: "This is a sample note for preview purposes.",
                              linkedItemIDs: [UUID()],
                              creationDate: Date())
        
        ItemCardNotesView(note: sampleNote)
            .previewLayout(.sizeThatFits) // Adjusts the preview to fit the content size.
            .padding()
    }
}
