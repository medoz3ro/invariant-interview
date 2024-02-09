import SwiftUI

struct EditNoteView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var note: Note
    var onSave: (Note) -> Void
    var onDelete: (Note) -> Void

    @State private var title: String
    @State private var content: String
    @State private var linkedItemIDs: [UUID]
    @State private var isShowingItemPicker = false
    @State private var activeAlert: ActiveAlert?

    @State private var items: [Item] = [] // Assuming you have a way to load these, if needed for picker

    enum ActiveAlert: Identifiable {
        case discardChanges, deleteConfirmation

        var id: Int {
            self.hashValue
        }
    }

    init(note: Binding<Note>, onSave: @escaping (Note) -> Void, onDelete: @escaping (Note) -> Void) {
        self._note = note
        self.onSave = onSave
        self.onDelete = onDelete
        self._title = State(initialValue: note.wrappedValue.title)
        self._content = State(initialValue: note.wrappedValue.note ?? "")
        self._linkedItemIDs = State(initialValue: note.wrappedValue.linkedItemIDs)
    }

    private func hasChanges() -> Bool {
        note.title != title || note.note != content || note.linkedItemIDs != linkedItemIDs
    }

    private func saveNote() {
        let updatedNote = Note(id: note.id, title: title, note: content, linkedItemIDs: linkedItemIDs, creationDate: note.creationDate)
        onSave(updatedNote)
        presentationMode.wrappedValue.dismiss()
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextEditor(text: $content).frame(height: 200)

                Section(header: Text("Linked Items")) {
                    Button("Manage Linked Items") {
                        isShowingItemPicker = true
                    }
                    // Optionally display linked items summary or detailed view here
                }

                Section {
                    Button("Delete Note", role: .destructive) {
                        activeAlert = .deleteConfirmation
                    }
                }
            }
            .navigationTitle("Edit Note")
            .navigationBarItems(leading: Button("Cancel") {
                if hasChanges() {
                    activeAlert = .discardChanges
                } else {
                    presentationMode.wrappedValue.dismiss()
                }
            }, trailing: Button("Save") {
                saveNote()
            })
            .alert(item: $activeAlert) { alertType in
                switch alertType {
                case .discardChanges:
                    return Alert(
                        title: Text("Discard Changes?"),
                        message: Text("Are you sure you want to discard your changes?"),
                        primaryButton: .destructive(Text("Discard")) {
                            presentationMode.wrappedValue.dismiss()
                        },
                        secondaryButton: .cancel()
                    )
                case .deleteConfirmation:
                    return Alert(
                        title: Text("Confirm Delete"),
                        message: Text("Are you sure you want to delete this note?"),
                        primaryButton: .destructive(Text("Delete")) {
                            onDelete(note)
                            presentationMode.wrappedValue.dismiss()
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .sheet(isPresented: $isShowingItemPicker) {
                // Assuming ItemPickerView can accept and modify linkedItemIDs
                ItemPickerView(linkedItemIDs: $linkedItemIDs)
            }
        }
    }
}

struct EditNoteView_Previews: PreviewProvider {
    static var previews: some View {
        EditNoteView(note: .constant(Note(id: UUID(), title: "Sample Title", note: "Sample Note Content", linkedItemIDs: [], creationDate: Date())), onSave: { _ in }, onDelete: { _ in })
    }
}
