//
//  NotesListScreen.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 06.02.2024..
//

import SwiftUI

struct NotesListScreen: View {
    // Mock data for notes
    private var notes: [Note] = [
        Note(id: UUID(), title: "Grocery List", note: "Eggs, Milk, Bread", creationDateNote: Date()),
        Note(id: UUID(), title: "To-Do", note: "Call the plumber, Schedule car service", creationDateNote: Date()),
        Note(id: UUID(), title: "Work Notes", note: "Prepare presentation for next meeting", creationDateNote: Date())
    ]
    
    var body: some View {
        VStack {
            // Header
            TitleView()
                .padding(.bottom, 10)
            
            // List of notes
            List(notes) { note in
                NavigationLink(destination: Text(note.note)) { // Placeholder for detail view
                    ItemCardNotesView(note: note)
                }
            }
            
            // Bottom navigation
            NavigationNotesView()
                .padding(.top, 10)
        }
    }
}

struct NotesHomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        NotesListScreen()
    }
}

