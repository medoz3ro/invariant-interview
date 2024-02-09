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
    
    @State private var noteTitle: String = ""
    @State private var noteContent: String = ""
    @State private var linkedItemIDs: [UUID] = []
    @State private var isShowingItemPicker = false
    @State private var items: [Item] = [] // Assuming you have a way to load these, if needed for the picker view

    // This mirrors the approach in ItemCardAddView for disabling the "Add" button conditionally
    var isAddButtonDisabled: Bool {
        noteTitle.isEmpty || noteContent.isEmpty
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $noteTitle)
                TextField("Note", text: $noteContent)
                
                Section(header: Text("Linked Items")) {
                    Button("Manage Linked Items") {
                        isShowingItemPicker = true
                    }
                }
            }
            .navigationTitle("Add Note")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Add") {
                let newNote = Note(title: noteTitle, note: noteContent, linkedItemIDs: linkedItemIDs)
                addNote(newNote)
                presentationMode.wrappedValue.dismiss()
            }.disabled(isAddButtonDisabled))
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

