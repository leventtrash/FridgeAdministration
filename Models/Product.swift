//
//  Product.swift
//  FridgeAdministration
//
//  Created by Levent Aydogan on 18.02.25.
//
import Foundation

struct Product: Codable, Identifiable {
    let id: Int
    let barcode: String
    let name: String
    let brand: String
    let imageUrl: String
}
