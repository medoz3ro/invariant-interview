import SwiftUI

struct NotesEditView: View {
    @Binding var note: Note? // Optional note for edit
    @Environment(\.presentationMode) var presentationMode
    @State private var noteTitle: String = ""
    @State private var noteContent: String = ""
    @State private var linkedItemIDs: [UUID] = []
    @State private var showingDeleteConfirmation = false // State for showing delete confirmation
    @State private var showingDiscardAlert = false
    @State private var isModified = false // Tracks if any changes have been made
    @State private var items: [Item] = [] // This would be fetched from DataManager
    private let dataManager = DataManager()

    var onSave: (Note) -> Void
    var onDelete: (Note) -> Void

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $noteTitle, onEditingChanged: { _ in isModified = true })
                TextEditor(text: $noteContent)
                    .frame(height: 200)
                    .onChange(of: noteContent) { _ in isModified = true }
                
                Section(header: Text("Linked Items")) {
                    ForEach(items) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            if linkedItemIDs.contains(item.id) {
                                Image(systemName: "checkmark")
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            isModified = true
                            if linkedItemIDs.contains(item.id) {
                                linkedItemIDs.removeAll { $0 == item.id }
                            } else {
                                linkedItemIDs.append(item.id)
                            }
                        }
                    }
                }
                
                if note != nil { // Show delete button only if editing an existing note
                    Button("Delete Note", role: .destructive) {
                        showingDeleteConfirmation = true
                    }
                }
            }
            .navigationTitle(note != nil ? "Edit Note" : "Add Note")
            .navigationBarItems(
                leading: Button("Cancel") {
                    if isModified {
                        showingDiscardAlert = true
                    } else {
                        presentationMode.wrappedValue.dismiss()
                    }
                },
                trailing: Button("Save") {
                    let updatedOrNewNote = Note(id: note?.id ?? UUID(), title: noteTitle, note: noteContent, linkedItemIDs: linkedItemIDs, creationDate: note?.creationDate ?? Date())
                    onSave(updatedOrNewNote)
                    presentationMode.wrappedValue.dismiss()
                }
            )
            .alert(isPresented: $showingDiscardAlert) {
                Alert(
                    title: Text("Discard Changes?"),
                    message: Text("You have unsaved changes. Are you sure you want to leave?"),
                    primaryButton: .destructive(Text("Discard")) {
                        presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel()
                )
            }
            .alert(isPresented: $showingDeleteConfirmation) {
                Alert(
                    title: Text("Confirm Delete"),
                    message: Text("This action cannot be undone."),
                    primaryButton: .destructive(Text("Delete")) {
                        if let noteToDelete = note {
                            onDelete(noteToDelete)
                            presentationMode.wrappedValue.dismiss()
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
            .onAppear {
                items = dataManager.loadItems() // Load items to link
                if let editingNote = note {
                    noteTitle = editingNote.title
                    noteContent = editingNote.note ?? ""
                    linkedItemIDs = editingNote.linkedItemIDs
                }
            }
        }
    }
}

struct NotesEditView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyNote = Note(id: UUID(), title: "Preview Note", note: "This is a preview note content.", linkedItemIDs: [], creationDate: Date())
        NotesEditView(note: .constant(dummyNote), onSave: { _ in }, onDelete: { _ in })
    }
}
