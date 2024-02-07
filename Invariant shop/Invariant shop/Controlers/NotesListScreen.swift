import SwiftUI

struct NotesListScreen: View {
    @ObservedObject var rootViewManager: RootViewManager
    private let dataManager = DataManager()
    @State private var notes: [Note] = []
    @State private var selectedNote: Note? // Add this line to track the selected note
    
    public init(rootViewManager: RootViewManager) {
        self.rootViewManager = rootViewManager
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                TitleView().padding(.bottom, 10)
                HStack {
                    Spacer()
                    VStack {
                        ForEach(notes) { note in
                            Button(action: {
                                self.selectedNote = note // Set the selectedNote on button tap
                            }) {
                                ItemCardNotesView(note: note)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
                Spacer()
                NavigationNotesView(rootViewManager: rootViewManager)
                    .frame(maxWidth: .infinity, maxHeight: 20, alignment: .bottom)
                    .background(Color("Bottom").edgesIgnoringSafeArea(.bottom).opacity(0))
            }
            .sheet(item: $selectedNote) { note in
                EditNoteView(note: Binding.constant(note), onSave: { updatedNote in
                    // Find the index of the updated note and replace it
                    if let index = self.notes.firstIndex(where: { $0.id == updatedNote.id }) {
                        self.notes[index] = updatedNote
                    }
                    self.dataManager.saveNotes(self.notes) // Corrected to call saveNotes
                    self.selectedNote = nil // Reset the selectedNote to dismiss the sheet
                }, onDelete: { noteToDelete in
                    self.notes.removeAll { $0.id == noteToDelete.id }
                    self.dataManager.saveNotes(self.notes) // Corrected to call saveNotes
                    self.selectedNote = nil // Reset the selectedNote to dismiss the sheet
                })
            }
            
        }
        .onAppear {
            self.notes = self.dataManager.loadNotes()
        }
    }
}

struct NotesHomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        let previewRootViewManager = RootViewManager()
        NotesListScreen(rootViewManager: previewRootViewManager)
    }
}
