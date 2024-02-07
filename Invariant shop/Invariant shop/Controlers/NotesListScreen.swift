//
//  NotesListScreen.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 06.02.2024..
//

import SwiftUI

struct NotesListScreen: View {
    
    @ObservedObject var rootViewManager: RootViewManager
    
    // Inject DataManager dependency
    private let dataManager = DataManager()
    
    // Track notes using State
    @State private var notes: [Note] = []
    
    public init(rootViewManager: RootViewManager) {
        self.rootViewManager = rootViewManager
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                TitleView()
                    .padding(.bottom, 10)
                
                ForEach(notes) { note in
                    if let noteText = note.note {
                        NavigationLink(destination: Text(noteText)) {
                            ItemCardNotesView(note: note)
                                .frame(maxWidth: .infinity)
                        }
                    }
                }

                .padding(.horizontal) // Add padding to the sides
                
                // Bottom navigation
                Spacer() // Pushes the bottom navigation to the bottom of the screen
                NavigationNotesView(rootViewManager: rootViewManager)
                    .frame(maxWidth: .infinity, maxHeight: 20, alignment: .bottom)
                    .background(Color("Bottom").edgesIgnoringSafeArea(.bottom).opacity(0))
            }
        }
        .onAppear {
            // Load notes from DataManager
            notes = dataManager.loadNotes()
        }
    }
}

struct NotesHomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of RootViewManager for the preview
        let previewRootViewManager = RootViewManager()
        NotesListScreen(rootViewManager: previewRootViewManager)
    }
}
