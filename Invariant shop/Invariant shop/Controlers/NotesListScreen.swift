import SwiftUI

struct NotesListScreen: View {
    @ObservedObject var rootViewManager: RootViewManager
    @State private var isAiChatViewPresented = false
    @State private var notes: [Note] = []
    @State private var selectedNote: Note?
    @State private var currentSort: SortType = .titleAscendingCreationDateDescending
    private let dataManager = DataManager()
    var chatController: ChatController

    
    public init(rootViewManager: RootViewManager, chatController: ChatController) {
        self.rootViewManager = rootViewManager
        self.chatController = chatController
    }

    
    private func loadNotes() {
        notes = dataManager.loadNotes()
        sortNotes()
    }
    
    enum SortType {
        case titleAscendingCreationDateDescending
        case titleDescendingCreationDateAscending
    }
    
    private func addNote(_ note: Note) {
        notes.append(note)
        dataManager.saveNotes(notes)
    }
    
    private func deleteNote(noteToDelete: Note) {
        if let index = notes.firstIndex(where: { $0.id == noteToDelete.id }) {
            notes.remove(at: index)
            dataManager.saveNotes(notes)
        }
        selectedNote = nil
    }
    
    private func saveNote(_ updatedNote: Note) {
        if let index = notes.firstIndex(where: { $0.id == updatedNote.id }) {
            notes[index] = updatedNote
            sortNotes()
            dataManager.saveNotes(notes)
        } else {
            print("Note not found for update; this should not happen.")
        }
    }
    
    private func toggleSort() {
        switch currentSort {
        case .titleAscendingCreationDateDescending:
            currentSort = .titleDescendingCreationDateAscending
        case .titleDescendingCreationDateAscending:
            currentSort = .titleAscendingCreationDateDescending
        }
        sortNotes()
    }
    
    private func sortNotes() {
        switch currentSort {
        case .titleAscendingCreationDateDescending:
            notes.sort {
                if $0.title.lowercased() == $1.title.lowercased() {
                    return $0.creationDate > $1.creationDate
                }
                return $0.title.lowercased() < $1.title.lowercased()
            }
        case .titleDescendingCreationDateAscending:
            notes.sort {
                if $0.title.lowercased() == $1.title.lowercased() {
                    return $0.creationDate < $1.creationDate
                }
                return $0.title.lowercased() > $1.title.lowercased()
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 10) {
                VStack(spacing: 0) {
                    Color("Title")
                    
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
            
            NavigationNotesView(rootViewManager: rootViewManager, onSort: self.toggleSort, addNote: self.addNote)
                .frame(maxWidth: .infinity, maxHeight: 20, alignment: .bottom)
                .background(Color("Bottom").edgesIgnoringSafeArea(.bottom).opacity(0))
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        self.isAiChatViewPresented.toggle()
                    }) {
                        ZStack {
                            Circle()
                                .foregroundColor(Color("aibackground").opacity(0.5))
                                .frame(width: 50, height: 50)
                            Text("AI")
                                .foregroundColor(Color("Text"))
                                .font(.headline)
                        }
                        .padding(16)
                    }
                }
                .padding(.bottom, 20)
            }
        }
        .onAppear(perform: {
            loadNotes()
            currentSort = .titleAscendingCreationDateDescending
        })
        
        .sheet(isPresented: $isAiChatViewPresented) {
            AiChatView(chatController: chatController)
        }
        
        .sheet(item: $selectedNote) { selectedNote in
            EditNoteView(note: .constant(selectedNote), onSave: { updatedNote in
                saveNote(updatedNote)
            }, onDelete: { noteToDelete in
                deleteNote(noteToDelete: noteToDelete)
            })
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct NotesListScreen_Previews: PreviewProvider {
    static var previews: some View {
        let openAIService = OpenAIService(apiKey: "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")
        let chatController = ChatController(openAIService: openAIService)
        NotesListScreen(rootViewManager: RootViewManager(), chatController: chatController)
    }
}




