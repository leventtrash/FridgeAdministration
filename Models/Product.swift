//
//  Product.swift
//  FridgeAdministration
//
//  Created by Levent Aydogan on 18.02.25.
//
import Foundation

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let brand: String
    let barcode: String
    let imageUrl: String
    let expiryDate: String
}
