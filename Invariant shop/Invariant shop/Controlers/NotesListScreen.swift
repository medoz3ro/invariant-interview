import SwiftUI

struct NotesListScreen: View {
    @ObservedObject var rootViewManager: RootViewManager
    private let dataManager = DataManager()
    @State private var notes: [Note] = []
    @State private var selectedNote: Note?
    
    public init(rootViewManager: RootViewManager) {
        self.rootViewManager = rootViewManager
    }
    
    private func loadNotes() {
        self.notes = self.dataManager.loadNotes()
    }
    
    func sortNotes() {
        notes.sort {
            if $0.title != $1.title {
                return $0.title < $1.title
            } else if $0.linkedItemIDs.count != $1.linkedItemIDs.count {
                return $0.linkedItemIDs.count < $1.linkedItemIDs.count
            } else {
                return $0.id.uuidString > $1.id.uuidString
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 15) {
                    TitleView(title: "Notes")
                        .frame(maxWidth: .infinity, alignment: .top)

                    
                    ForEach(notes) { note in
                        ItemCardNotesView(note: note)
                            .padding(.horizontal)
                    }
                }
                .padding(.bottom, 70)
            }
            .background(Color("Title").edgesIgnoringSafeArea(.top).opacity(0))
            NavigationNotesView(rootViewManager: rootViewManager, onSort: sortNotes)
                .frame(maxWidth: .infinity, maxHeight: 20, alignment: .bottom)
                .background(Color("Bottom").edgesIgnoringSafeArea(.bottom).opacity(0))
        }
        .onAppear(perform: loadNotes)
        .sheet(item: $selectedNote) { selectedNote in
            EditNoteView(note: Binding.constant(selectedNote), onSave: { updatedNote in
                if let index = self.notes.firstIndex(where: { $0.id == updatedNote.id }) {
                    self.notes[index] = updatedNote
                }
                self.dataManager.saveNotes(self.notes)
                self.selectedNote = nil
            }, onDelete: { noteToDelete in
                self.notes.removeAll { $0.id == noteToDelete.id }
                self.dataManager.saveNotes(self.notes)
                self.selectedNote = nil
            })
        }
    }
}

struct NotesListScreen_Previews: PreviewProvider {
    static var previews: some View {
        NotesListScreen(rootViewManager: RootViewManager())
    }
}




struct NotesHomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        let previewRootViewManager = RootViewManager()
        NotesListScreen(rootViewManager: previewRootViewManager)
    }
}

