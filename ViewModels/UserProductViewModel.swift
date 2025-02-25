//
//  UserProductViewModel.swift
//  FridgeAdministration
//
//  Created by Levent Aydogan on 18.02.25.
//
import Foundation
import Combine

class UserProductViewModel: ObservableObject {
    @Published var userProducts: [UserProduct] = [
        UserProduct(id: 1, barcode: "4008400401244", name: "Milch", expiryDate: "2025-03-10"),
        UserProduct(id: 2, barcode: "5000112545975", name: "Apfelsaft", expiryDate: "2025-05-15")
    ]
    
    func fetchUserProducts() {
        // Aktuell gibt es keine API-Anbindung, daher bleibt die Liste unverändert
        DispatchQueue.main.async {
            self.userProducts = self.userProducts
        }
    }
    
    func saveProduct(barcode: String, expiryDate: String) {
        let mockProducts: [String: String] = [
            "4008400401244": "Milch",
            "5000112545975": "Apfelsaft"
        ]
        
        if let name = mockProducts[barcode] {
            let newProduct = UserProduct(id: userProducts.count + 1, barcode: barcode, name: name, expiryDate: expiryDate)
            DispatchQueue.main.async {
                self.userProducts.append(newProduct)
            }
        }
    }
    
    func deleteProduct(barcode: String) {
        DispatchQueue.main.async {
            self.userProducts.removeAll { $0.barcode == barcode }
        }
    }
}
