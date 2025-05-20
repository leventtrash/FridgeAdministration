import SwiftUI
import CodeScanner

struct BarcodeScannerView: View {
    @StateObject private var productViewModel = ProductViewModel()
    @StateObject private var userProductViewModel = UserProductViewModel()
    @State private var scannedBarcode: String = ""
    @State private var expiryDate: String = ""
    @State private var isShowingScanner = false
    
    var body: some View {
        VStack {
            Button(action: { isShowingScanner = true }) {
                Image(systemName: "qrcode.viewfinder")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding()
            }
            .background(Color.blue.opacity(0.2))
            .clipShape(Circle())
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.ean13, .ean8, .upce], completion: handleScan)
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
            Text(productViewModel.product?.barcode ?? "Kein Barcode vorhanden")
            Text(scannedBarcode)
        }
        .navigationTitle("Scanner")
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let result):
            scannedBarcode = result.string
            productViewModel.fetchProduct(barcode: scannedBarcode)
        case .failure(let error):
            print("Scan-Fehler: \(error.localizedDescription)")
        }
    }
}

#Preview {
    BarcodeScannerView()
}
