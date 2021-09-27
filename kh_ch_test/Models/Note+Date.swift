//
//  Note.swift
//  kh_ch_test
//
//  Created by temir on 27.09.2021.
//

import Foundation

final class Note: Codable {
    let id: UUID
    var lastUpdatedDate: Date
    var body: String
    
    init(body: String) {
        self.id = UUID()
        self.lastUpdatedDate = Date()
        self.body = body
    }
}

extension Date {
    func formattedStringDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd:MM:yyyy"
        
        return formatter.string(from: self)
    }
}
