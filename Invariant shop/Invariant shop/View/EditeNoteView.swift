import SwiftUI

enum ActiveAlert: Identifiable {
    case discardChanges, deleteConfirmation
    
    // Conform to Identifiable
    var id: String {
        switch self {
        case .discardChanges:
            return "discardChanges"
        case .deleteConfirmation:
            return "deleteConfirmation"
        }
    }
}
    

struct EditNoteView: View {
    @Environment(\.presentationMode) var presentationMode
    var onSave: (Note) -> Void
    var onDelete: (Note) -> Void
    

    
    @Binding var note: Note
    @State private var title: String
    @State private var noteContent: String
    @State private var linkedItemIDs: [UUID]
    @State private var activeAlert: ActiveAlert?
    @State private var isShowingItemPicker = false
    
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
                TextEditor(text: $noteContent).frame(height: 200)
                
                Section(header: Text("Linked Items")) {
                    Button("Manage Linked Items") {
                        isShowingItemPicker = true
                    }
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
                if validateInput() {
                    saveNote()
                }
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
                ItemPickerView(linkedItemIDs: $linkedItemIDs)
            }
            .onAppear {
                items = dataManager.loadItems()
            }
        }
    }
    
    private func hasChanges() -> Bool {
        return note.title != title || note.note != noteContent || note.linkedItemIDs != linkedItemIDs
    }
    
    private func saveNote() {
        let updatedNote = Note(id: note.id, title: title, note: noteContent, linkedItemIDs: linkedItemIDs, creationDate: note.creationDate)
        onSave(updatedNote)
        presentationMode.wrappedValue.dismiss()
    }
    
    private func validateInput() -> Bool {
        if title.isEmpty {
            print("Title cannot be empty.")
            return false
        }
        return true
    }
}

struct EditNoteView_Previews: PreviewProvider {
    static var previews: some View {
        EditNoteView(note: .constant(Note(id: UUID(), title: "Sample Title", note: "Sample Note Content", linkedItemIDs: [], creationDate: Date())), onSave: { _ in }, onDelete: { _ in })
    }
}
