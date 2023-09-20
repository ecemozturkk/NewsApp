//
//  DateFormatter.swift
//  NewsApp
//
//  Created by Ecem Öztürk on 20.09.2023.
//

import Foundation

extension DateFormatter {
    static func formattedDate(from dateString: String?) -> String {
        guard let dateString = dateString else {
            return "Date Not Available"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Kaynak tarih formatı
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm" // Hedef tarih formatı (örnek: 29.08.2023 19:20)
            return dateFormatter.string(from: date)
        } else {
            return "Invalid Date"
        }
    }
}

