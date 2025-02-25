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
            "4008400401244": Product(id: 1, barcode: "4008400401244", name: "Milch", brand: "Alpro", imageUrl: "https://via.placeholder.com/100"),
            "5000112545975": Product(id: 2, barcode: "5000112545975", name: "Apfelsaft", brand: "Hohes C", imageUrl: "https://via.placeholder.com/100")
        ]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.product = mockProducts[barcode] ?? nil
        }
    }
}
