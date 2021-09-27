//
//  NotesStorage.swift
//  kh_ch_test
//
//  Created by temir on 27.09.2021.
//

import Foundation

final class NotesStorage {
    
    private init() {}
    
    private var notes: [Note] {
        get {
            return getNotes()
        }
        set {
            setNotes(newValue)
        }
    }
    
    static let shared = NotesStorage()
    
    func add(_ note: Note) {
        notes.append(note)
    }
    
    func get() -> [Note] {
        return notes
    }
    
    func get(with id: UUID) -> Note? {
        return notes.first(where: { $0.id == id })
    }
    
    func remove(for id: UUID) {
        notes.removeAll(where: { $0.id == id })
    }
    
    func update(for id: UUID, with body: String) {
        guard let note = get(with: id) else { return }
        note.body = body
        remove(for: id)
        notes.append(note)
    }
    
}

//MARK: - Private methods
private extension NotesStorage {
    
    // - Get notes from userdefaults storage, unwrap and try decode it from JSON
    func getNotes() -> [Note] {
        guard
            let data = UserDefaults.standard.data(forKey: "notes"),
            let notes = try? JSONDecoder().decode([Note].self, from: data) else {
                return [Note]()
        }
        return notes
    }
    
    // - Encode notes to JSON and store it in userdefaults
    func setNotes(_ newValue: [Note]) {
        guard let data = try? JSONEncoder().encode(newValue) else { return }
        UserDefaults.standard.setValue(data, forKey: "notes")
    }
}
