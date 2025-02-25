//
//  Extensions.swift
//  FridgeAdministration
//
//  Created by Levent Aydogan on 18.02.25.
//
import Foundation

extension String {
    func toDate(format: String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}
