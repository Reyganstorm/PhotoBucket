//
//  DateManager.swift
//  PhotoBucket
//
//  Created by Руслан Штыбаев on 16.05.2022.
//

import Foundation

class DateManager {
    static let shared = DateManager()
    private init() {}
    
    private func getDate(_ string: String) -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: string) {
            return date
        }
        return nil
    }

    func getStrFromDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let rightDate = dateFormatter.string(from: date)
        return rightDate
    }

    func changeWrongStringDateToRight(_ wrongFormat: String) -> String {
    if let dateString = getDate(wrongFormat) {
        return getStrFromDate(dateString)
        }
        return "Unknowed"
    }
}
