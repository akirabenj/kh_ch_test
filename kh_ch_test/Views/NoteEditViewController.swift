//
//  NoteEditViewController.swift
//  kh_ch_test
//
//  Created by temir on 28.09.2021.
//

import Foundation
import UIKit

class NoteEditViewController: UIViewController {
    
    private enum NoteEditState {
        case edit
        case new
    }
    
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    
    private var state: NoteEditState = .new
    private var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.layer.cornerRadius = 6.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        textField.layer.cornerRadius = 5.0
        textField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch state {
        case .new:
            textField.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            textField.text = "Enter here note text"
        case .edit:
            textField.textColor = .label
            textField.text = note?.body
        }
    }
    
    func setNote(_ noteID: UUID) {
        state = .edit
        self.note = NotesStorage.shared.get(with: noteID)
        
    }
    
    @IBAction private func doneButtonAction(_ sender: Any) {
        switch state {
        case .edit:
            if let note = note {
                NotesStorage.shared.update(for: note.id, with: textField.text)
            }
        case .new:
            let note = Note(body: textField.text)
            NotesStorage.shared.add(note)
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension NoteEditViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) {
            textView.text = nil
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == nil {
            textView.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
    }
}
