import SwiftUI

struct NotesListScreen: View {
    @ObservedObject var rootViewManager: RootViewManager
    private let dataManager = DataManager()
    @State private var notes: [Note] = []
    @State private var selectedNote: Note? // Add this line to track the selected note
    
    public init(rootViewManager: RootViewManager) {
        self.rootViewManager = rootViewManager
    }
    
    private func loadNotes() {
        self.notes = self.dataManager.loadNotes()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 15) { // Adjust spacing here if needed
                    TitleView()
                        .frame(maxWidth: .infinity, alignment: .top)
                    
                    ForEach(notes) { note in
                        ItemCardNotesView(note: note)
                            .padding(.horizontal) // Ensures padding on both sides.
                            .fixedSize(horizontal: false, vertical: true) // Limits expansion tendency vertically.
                            .onTapGesture {
                                self.selectedNote = note
                        }
                        Spacer().frame(height: 70)
                    }
                    
                    .padding(.horizontal) // Add padding to ensure they are not edge-to-edge
                }
                .padding(.bottom, 70) // Adjust bottom padding instead of using Spacer
            }
            NavigationNotesView(rootViewManager: rootViewManager)
                .frame(maxWidth: .infinity, maxHeight: 20, alignment: .bottom)
                .background(Color("Bottom").edgesIgnoringSafeArea(.bottom).opacity(0))
        }
        .onAppear(perform: loadNotes)
        .sheet(item: $selectedNote) { selectedNote in
            EditNoteView(note: Binding.constant(selectedNote), onSave: { updatedNote in
                // Assuming this is the correct function to update a note
                if let index = self.notes.firstIndex(where: { $0.id == updatedNote.id }) {
                    self.notes[index] = updatedNote
                }
                self.dataManager.saveNotes(self.notes) // Save the updated notes array
                self.selectedNote = nil // Reset the selectedNote to dismiss the sheet
            }, onDelete: { noteToDelete in
                // Correctly use the 'noteToDelete' parameter
                self.notes.removeAll { $0.id == noteToDelete.id }
                self.dataManager.saveNotes(self.notes) // Save the notes array after deletion
                self.selectedNote = nil // Reset the selectedNote to dismiss the sheet
            })
        }
    }
}



struct NotesHomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        let previewRootViewManager = RootViewManager()
        NotesListScreen(rootViewManager: previewRootViewManager)
    }
}

