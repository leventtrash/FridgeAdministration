//
//  Product.swift
//  FridgeAdministration
//
//  Created by Levent Aydogan on 18.02.25.
//
import Foundation

struct Product: Identifiable, Codable {
    let id: UUID
    var name: String
    var barcode: String
    var expirationDate: Date
    var quantity: Int
    var dateAdded: Date
    
    init(id: UUID = UUID(), name: String, barcode: String, expirationDate: Date, quantity: Int, dateAdded: Date = Date()) {
        self.id = id
        self.name = name
        self.barcode = barcode
        self.expirationDate = expirationDate
        self.quantity = quantity
        self.dateAdded = dateAdded
    }
}

// MARK: - Product Sorting
extension Product {
    var daysUntilExpiration: Int {
        Calendar.current.dateComponents([.day], from: Date(), to: expirationDate).day ?? 0
    }
    
    var isExpired: Bool {
        Date() > expirationDate
    }
    
    var isExpiringSoon: Bool {
        daysUntilExpiration <= 7 && !isExpired
    }
}
