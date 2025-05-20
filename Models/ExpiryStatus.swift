// ExpiryStatus.swift
import UIKit

enum ExpiryStatus {
    case good
    case expiringSoon
    case expired
    
    var color: UIColor {
        switch self {
        case .good:
            return .systemGreen
        case .expiringSoon:
            return .systemOrange
        case .expired:
            return .systemRed
        }
    }
}
