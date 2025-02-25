//
//  ProductListView.swift
//  FridgeAdministration
//
//  Created by Levent Aydogan on 18.02.25.
//


import SwiftUI

struct ProductListView: View {
    @StateObject private var userProductViewModel = UserProductViewModel()
    
    var body: some View {
        List {
            ForEach(userProductViewModel.userProducts) { userProduct in
                HStack {
                    VStack(alignment: .leading) {
                        Text(userProduct.name)
                            .font(.headline)
                        Text("Ablaufdatum: \(userProduct.expiryDate)")
                            .font(.subheadline)
                    }
                    Spacer()
                    Button(action: {
                        userProductViewModel.deleteProduct(barcode: userProduct.barcode)
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .onAppear {
            userProductViewModel.fetchUserProducts()
        }
        .navigationTitle("Gespeicherte Produkte")
    }
}
