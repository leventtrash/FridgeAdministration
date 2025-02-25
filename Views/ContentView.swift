//
//  ContentView.swift
//  FridgeAdministration
//
//  Created by Levent Aydogan on 11.02.25.
//



import SwiftUI

struct ContentView: View {
    @StateObject private var productViewModel = ProductViewModel()
    @StateObject private var userProductViewModel = UserProductViewModel()
    @State private var scannedBarcode: String = ""
    @State private var expiryDate: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                BarcodeScannerView(scannedCode: $scannedBarcode)
                    .frame(height: 300)
                    .onChange(of: scannedBarcode) {
                        productViewModel.fetchProduct(barcode: scannedBarcode)
                    }
                
                if let product = productViewModel.product {
                    VStack {
                        Text("Produkt: \(product.name)")
                        Text("Marke: \(product.brand)")
                        AsyncImage(url: URL(string: product.imageUrl))
                            .frame(width: 100, height: 100)
                        TextField("Ablaufdatum eingeben", text: $expiryDate)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        Button("Speichern") {
                            userProductViewModel.saveProduct(barcode: product.barcode, expiryDate: expiryDate)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                
                NavigationLink("Gespeicherte Produkte anzeigen", destination: ProductListView())
                    .padding()
            }
            .navigationTitle("FridgeAdministration")
        }
    }
}


#Preview {
    ContentView()
}
