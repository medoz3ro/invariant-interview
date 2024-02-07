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
    @State private var isShowingItemPicker = false // For showing the ItemPickerView
    
    // Assume DataManager is accessible and can provide items
    private let dataManager = DataManager()
    @State private var items: [Item] = [] // This would be fetched from DataManager
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $noteTitle)
                TextField("Note", text: $noteContent)
                
                Section(header: Text("Linked Items")) {
                    Button("Add Item") {
                        isShowingItemPicker = true // Present ItemPickerView
                    }
                }
                
                // Existing code for other form fields
            }
            .navigationTitle("Add Note")
            .navigationBarItems(leading: Button("Back") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                let newNoteToSave = Note(title: noteTitle, note: noteContent, linkedItemIDs: linkedItemIDs)
                addNote(newNoteToSave)
                // Save the new note locally
                dataManager.saveNote(newNoteToSave)
                presentationMode.wrappedValue.dismiss()
            }.disabled(noteTitle.isEmpty))
            .sheet(isPresented: $isShowingItemPicker) {
                ItemPickerView(linkedItemIDs: $linkedItemIDs)
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


