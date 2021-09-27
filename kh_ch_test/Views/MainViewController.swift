//
//  ViewController.swift
//  kh_ch_test
//
//  Created by temir on 28.09.2021.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    
    private var notes = NotesStorage.shared.get()
    private var isEdit = false
    private var selectedNoteID: UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.layer.cornerRadius = 6.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notes = NotesStorage.shared.get()
        tableView.reloadData()
    }

    @IBAction private func addButtonAction(_ sender: Any) {
        isEdit = false
        performSegue(withIdentifier: "showNoteEdit", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            isEdit,
            let destination = segue.destination as? NoteEditViewController,
            let noteID = selectedNoteID {
                destination.setNote(noteID)
        }
    }
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as? NotesTableViewCell else {
            return UITableViewCell()
        }
        cell.setCell(notes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isEdit = true
        selectedNoteID = notes[indexPath.row].id
        performSegue(withIdentifier: "showNoteEdit", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removingNoteID = notes[indexPath.row].id
            notes.remove(at: indexPath.row)
            NotesStorage.shared.remove(for: removingNoteID)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

