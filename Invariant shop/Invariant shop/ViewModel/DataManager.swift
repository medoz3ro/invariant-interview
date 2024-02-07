// DataManager.swift

import Foundation

class DataManager {
    private let itemsKey = "items"
    private let notesKey = "notes" // Add a key for notes

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
    
    // Add a method to save a single note locally
    func saveNote(_ note: Note) {
        var notes = loadNotes()
        notes.append(note)
        
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(notes)
            UserDefaults.standard.set(encoded, forKey: notesKey)
        } catch {
            print("Failed to encode notes: \(error)")
        }
    }
    
    // Add a method to load notes from UserDefaults
    func loadNotes() -> [Note] {
        guard let notesData = UserDefaults.standard.data(forKey: notesKey) else {
            print("No notes found")
            return []
        }

        let decoder = JSONDecoder()
        do {
            let notes = try decoder.decode([Note].self, from: notesData)
            return notes
        } catch {
            print("Failed to decode notes: \(error)")
            return []
        }
    }
    
    // Add a method to delete a note
    func deleteNote(_ note: Note) {
        var notes = loadNotes()
        notes.removeAll { $0.id == note.id }
        saveNote(note) // Corrected method call from saveNote to saveNotes
    }
}
