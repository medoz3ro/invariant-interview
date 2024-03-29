import Foundation
import Combine

class DataManager :  ObservableObject {
    private let itemsKey = "items"
    private let notesKey = "notes"
    
    
    
    func saveItems(_ items: [Item]) {
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(items)
            UserDefaults.standard.set(encoded, forKey: itemsKey)
        } catch {
            print("Failed to encode items: \(error)")
        }
    }
    
    func loadItems() -> [Item] {
        guard let itemsData = UserDefaults.standard.data(forKey: itemsKey) else {
            print("No items found")
            return []
        }
        
        let decoder = JSONDecoder()
        do {
            let items = try decoder.decode([Item].self, from: itemsData)
            return items
        } catch {
            print("Failed to decode items: \(error)")
            return []
        }
    }
    
    func saveNote(_ note: Note) {
        var notes = loadNotes()
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index] = note
        } else {
            notes.append(note)
        }
        saveNotes(notes)
    }
    
    func saveNotes(_ notes: [Note]) {
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(notes)
            UserDefaults.standard.set(encoded, forKey: notesKey)
        } catch {
            print("Failed to encode notes: \(error)")
        }
    }
    
    func loadNotes() -> [Note] {
        guard let notesData = UserDefaults.standard.data(forKey: notesKey) else {
            print("No notes found")
            return []
        }
        
        let decoder = JSONDecoder()
        do {
            var notes = try decoder.decode([Note].self, from: notesData)
            notes.sort {
                if $0.title != $1.title {
                    return $0.title < $1.title
                } else if $0.linkedItemIDs.count != $1.linkedItemIDs.count {
                    return $0.linkedItemIDs.count < $1.linkedItemIDs.count
                } else {
                    return $0.id.uuidString > $1.id.uuidString
                }
            }
            return notes
        } catch {
            print("Failed to decode notes: \(error)")
            return []
        }
    }
    
    
    func deleteNote(_ note: Note) {
        var notes = loadNotes()
        notes.removeAll { $0.id == note.id }
        saveNotes(notes)
    }
}
