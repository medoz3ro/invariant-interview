import SwiftUI

struct NotesListScreen: View {
    @ObservedObject var rootViewManager: RootViewManager
    private let dataManager = DataManager()
    @State private var notes: [Note] = []
    @State private var selectedNote: Note?
    @State private var isSortedAscending = false
    
    public init(rootViewManager: RootViewManager) {
        self.rootViewManager = rootViewManager
    }
    
    private func loadNotes() {
        notes = dataManager.loadNotes()

    }
    
    private func addNote(_ note: Note) {
        notes.append(note)
    }
    
    func sortNotes() {
        isSortedAscending.toggle()
        notes.sort {
            let titleComparison = $0.title.lowercased().compare($1.title.lowercased())
            if titleComparison != .orderedSame {
                return isSortedAscending ? titleComparison == .orderedAscending : titleComparison == .orderedDescending
            } else if $0.linkedItemIDs.count != $1.linkedItemIDs.count {
                return isSortedAscending ? $0.linkedItemIDs.count < $1.linkedItemIDs.count : $0.linkedItemIDs.count > $1.linkedItemIDs.count
            } else {
                return isSortedAscending ? $0.id.uuidString > $1.id.uuidString : $0.id.uuidString < $1.id.uuidString
            }
        }
    }
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
                VStack(spacing: 10) {
                    VStack(spacing: 0) {
                        Color("Title")
                            .frame(height: UIApplication.shared.windows.first?.safeAreaInsets.top)
                            .edgesIgnoringSafeArea(.top)
                        
                        TitleView(title: "Notes")
    
                    }
                    .frame(maxWidth: .infinity, maxHeight: 115, alignment: .top)
                    
                    
                    ScrollView {
                    ForEach(notes) { note in
                        ItemCardNotesView(note: note)
                            .onTapGesture {
                                self.selectedNote = note
                            }
                    }
                    .padding()
                }
            }
         
            
            NavigationNotesView(rootViewManager: rootViewManager, onSort: sortNotes, addNote: addNote)
                .frame(maxWidth: .infinity, maxHeight: 20, alignment: .bottom)
                .background(Color("Bottom").edgesIgnoringSafeArea(.bottom).opacity(0))
        }
        .onAppear(perform: {
            loadNotes()
            isSortedAscending = false
        })
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
        .edgesIgnoringSafeArea(.top)
    }
}

struct NotesListScreen_Previews: PreviewProvider {
    static var previews: some View {
        NotesListScreen(rootViewManager: RootViewManager())
    }
}



