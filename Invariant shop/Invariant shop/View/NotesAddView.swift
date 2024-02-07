//
//  NotesAddView.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 07.02.2024..
//

import SwiftUI

struct AddNotesView: View {
    @Environment(\.presentationMode) var presentationMode
    var addNote: (Note) -> Void // Closure to add a note
    
    @State private var noteTitle: String = ""
    @State private var noteContent: String = ""
    @State private var linkedItemIDs: [UUID] = [] // IDs of linked items

    // Assume DataManager is accessible and can provide items
    private let dataManager = DataManager()
    @State private var items: [Item] = [] // This would be fetched from DataManager
    @State private var newNote: Note? // Declare newNote at the appropriate scope
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $noteTitle)
                TextField("Note", text: $noteContent)
                // For simplicity, this is a TextField; replace with your UI for selecting linked items
                // This example does not fully implement linking items but sets up the structure
                
                Section(header: Text("Linked Items")) {
                    // Example of listing items to link (simplified)
                    ForEach(items) { item in
                        Button(item.name) {
                            // Simplified logic to toggle item linking
                            if linkedItemIDs.contains(item.id) {
                                linkedItemIDs.removeAll { $0 == item.id }
                            } else {
                                linkedItemIDs.append(item.id)
                            }
                        }
                        .foregroundColor(linkedItemIDs.contains(item.id) ? .blue : .primary)
                    }
                }
            }
            .navigationTitle("Add Note")
            .navigationBarItems(leading: Button("Back") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                newNote = Note(title: noteTitle, note: noteContent, linkedItemIDs: linkedItemIDs)
                addNote(newNote!) // Force unwrap here since it's guaranteed to exist
                // Save the new note locally
                if let newNote = newNote {
                    dataManager.saveNote(newNote)
                }
                presentationMode.wrappedValue.dismiss()
            }.disabled(noteTitle.isEmpty))
            .onAppear {
                items = dataManager.loadItems() // Load items to link
            }
            // Pass the newly created note to ItemCardNotesView if it exists
            if let newNote = newNote {
                ItemCardNotesView(note: newNote)
            }
        }
    }
}

    
struct AddNotesView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide a mock implementation of `addNote` for the preview
        AddNotesView(addNote: { note in
            // For the purpose of the preview, simply print the note to the console
            print("Adding note:", note)
        })
    }
}
