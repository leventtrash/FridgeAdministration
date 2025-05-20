//
//  ProductViewModel.swift
//  FridgeAdministration
//
//  Created by Levent Aydogan on 18.02.25.
//
import Foundation
import Combine
import SwiftUI

@MainActor
class ProductViewModel: ObservableObject {
    @Published private(set) var products: [Product] = []
    private let saveKey = "SavedProducts"
    
    init() {
        loadProducts()
    }
    
    // MARK: - CRUD Operations
    
    func addProduct(_ product: Product) {
        products.append(product)
        saveProducts()
    }
    
    func removeProduct(_ product: Product) {
        products.removeAll { $0.id == product.id }
        saveProducts()
    }
    
    func updateProduct(_ product: Product) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products[index] = product
            saveProducts()
        }
    }
    
    // MARK: - Sorting
    
    func getSortedProducts() -> [Product] {
        products.sorted { product1, product2 in
            if product1.isExpired && !product2.isExpired {
                return true
            } else if !product1.isExpired && product2.isExpired {
                return false
            } else {
                return product1.daysUntilExpiration < product2.daysUntilExpiration
            }
        }
    }
    
    // MARK: - Persistence
    
    private func saveProducts() {
        if let encoded = try? JSONEncoder().encode(products) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    private func loadProducts() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([Product].self, from: data) {
            products = decoded
        }
    }
}
