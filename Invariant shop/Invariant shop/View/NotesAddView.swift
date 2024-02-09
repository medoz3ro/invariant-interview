//
//  NotesAddView.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 07.02.2024..
//

import SwiftUI

struct AddNotesView: View {
    @Environment(\.presentationMode) var presentationMode
    var addNote: (Note) -> Void
    var onNoteAdded: (() -> Void)?

    
    
    @State private var noteTitle: String = ""
    @State private var noteContent: String = ""
    @State private var linkedItemIDs: [UUID] = []
    @State private var isShowingItemPicker = false
    
    
    private let dataManager = DataManager()
    @State private var items: [Item] = []
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $noteTitle)
                TextField("Note", text: $noteContent)
                
                Section(header: Text("Linked Items")) {
                    Button("Add Item") {
                        isShowingItemPicker = true
                    }
                }
            }
            .navigationTitle("Add Note")
            .navigationBarItems(leading: Button("Back") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Add") {
                let newNoteToSave = Note(title: noteTitle, note: noteContent, linkedItemIDs: linkedItemIDs)
                addNote(newNoteToSave)
                dataManager.saveNote(newNoteToSave)
                onNoteAdded?() // This should trigger the refresh in NotesListScreen
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
        AddNotesView(addNote: { note in
            print("Adding note:", note)
        })
    }
}


