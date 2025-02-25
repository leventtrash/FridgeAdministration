//
//  ProductViewModel.swift
//  FridgeAdministration
//
//  Created by Levent Aydogan on 18.02.25.
//
import Foundation
import Combine

class ProductViewModel: ObservableObject {
    @Published var product: Product?
    
    func fetchProduct(barcode: String) {
        let mockProducts: [String: Product] = [
            "4008400401244": Product(name: "Milch", brand: "Alpro", barcode: "4008400401244", imageUrl: "https://via.placeholder.com/100", expiryDate: "2025-03-10"),
            "5000112545975": Product(name: "Apfelsaft", brand: "Hohes C", barcode: "5000112545975", imageUrl: "https://via.placeholder.com/100", expiryDate: "2025-05-15")
        ]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.product = mockProducts[barcode] ?? nil
        }
    }
}
