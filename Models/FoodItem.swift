// FoodItem.swift
import Foundation

struct FoodItem: Codable, Identifiable {
    var id = UUID()
    var name: String
    var barcode: String
    var expiryDate: Date
    var quantity: Int
    var category: FoodCategory
    var notes: String?
    
    // Berechnete Eigenschaften für Ablaufstatus
    var daysUntilExpiry: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: Date(), to: expiryDate)
        return components.day ?? 0
    }
    
    var status: ExpiryStatus {
        switch daysUntilExpiry {
        case ..<0:
            return .expired
        case 0...3:
            return .expiringSoon
        default:
            return .good
        }
    }
}
