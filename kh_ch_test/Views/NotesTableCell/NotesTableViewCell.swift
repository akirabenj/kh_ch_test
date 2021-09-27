//
//  NotesTableCellView.swift
//  kh_ch_test
//
//  Created by temir on 28.09.2021.
//

import Foundation
import UIKit

class NotesTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var previewTitle: UILabel!
    @IBOutlet private weak var lastUpdateDateLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell(_ note: Note) {
        previewTitle?.text = note.body
        lastUpdateDateLabel?.text = note.lastUpdatedDate.formattedStringDate()
    }
}
