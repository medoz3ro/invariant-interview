
import SwiftUI

struct EditNoteView: View {
    @Environment(\.presentationMode) var presentationMode
    var onSave: (Note) -> Void
    var onDelete: (Note) -> Void
    
    @Binding var note: Note
    @State private var title: String
    @State private var noteContent: String
    @State private var linkedItemIDs: [UUID]
    @State private var showingDiscardAlert = false
    @State private var showingDeleteAlert = false
    
    // Assume DataManager is accessible and can provide items
    @State private var items: [Item] = []
    private let dataManager = DataManager()
    
    init(note: Binding<Note>, onSave: @escaping (Note) -> Void, onDelete: @escaping (Note) -> Void) {
        self._note = note
        self.onSave = onSave
        self.onDelete = onDelete
        self._title = State(initialValue: note.wrappedValue.title)
        self._noteContent = State(initialValue: note.wrappedValue.note ?? "")
        self._linkedItemIDs = State(initialValue: note.wrappedValue.linkedItemIDs)
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextEditor(text: $noteContent)
                    .frame(height: 200)
                
                Section(header: Text("Linked Items")) {
                    ForEach(items) { item in
                        Button(item.name) {
                            toggleItemLink(with: item.id)
                        }
                        .foregroundColor(linkedItemIDs.contains(item.id) ? .blue : .primary)
                    }
                }
            }
            .navigationTitle("Edit Note")
            .navigationBarItems(leading: Button("Cancel") {
                if hasChanges {
                    showingDiscardAlert = true
                } else {
                    presentationMode.wrappedValue.dismiss()
                }
            }, trailing: Button("Save") {
                saveNote()
            })
            .alert(isPresented: $showingDiscardAlert) {
                Alert(
                    title: Text("Discard Changes?"),
                    message: Text("Are you sure you want to discard your changes?"),
                    primaryButton: .destructive(Text("Discard")) {
                        presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel()
                )
            }
            .alert(isPresented: $showingDeleteAlert) {
                Alert(
                    title: Text("Confirm Delete"),
                    message: Text("Are you sure you want to delete this note?"),
                    primaryButton: .destructive(Text("Delete")) {
                        onDelete(note)
                        presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel()
                )
            }
            .onAppear {
                items = dataManager.loadItems() // Load items to link
            }
        }
    }
    
    private var hasChanges: Bool {
        return note.title != title || note.note != noteContent || note.linkedItemIDs != linkedItemIDs
    }
    
    private func toggleItemLink(with id: UUID) {
        if let index = linkedItemIDs.firstIndex(of: id) {
            linkedItemIDs.remove(at: index)
        } else {
            linkedItemIDs.append(id)
        }
    }
    
    private func saveNote() {
        let updatedNote = Note(id: note.id, title: title, note: noteContent, linkedItemIDs: linkedItemIDs, creationDate: note.creationDate)
        onSave(updatedNote)
        presentationMode.wrappedValue.dismiss()
    }
}

struct EditNoteView_Previews: PreviewProvider {
    static var previews: some View {
        EditNoteView(note: .constant(Note(id: UUID(), title: "Sample Title", note: "Sample Note Content", linkedItemIDs: [], creationDate: Date())), onSave: { _ in }, onDelete: { _ in })
    }
}
