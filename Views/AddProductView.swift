import SwiftUI

struct AddProductView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var viewModel: ProductViewModel
    
    let barcode: String?
    
    @State private var name = ""
    @State private var quantity = 1
    @State private var expirationDate = Date()
    
    init(barcode: String? = nil) {
        self.barcode = barcode
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Produktinformationen")) {
                    TextField("Produktname", text: $name)
                    
                    if let barcode = barcode {
                        Text("Barcode: \(barcode)")
                            .foregroundColor(.secondary)
                    }
                    
                    Stepper("Menge: \(quantity)", value: $quantity, in: 1...99)
                }
                
                Section(header: Text("Mindesthaltbarkeitsdatum")) {
                    DatePicker("MHD", selection: $expirationDate, displayedComponents: .date)
                }
            }
            .navigationTitle("Produkt hinzufügen")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Speichern") {
                        saveProduct()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
    
    private func saveProduct() {
        let product = Product(
            name: name,
            barcode: barcode ?? "",
            expirationDate: expirationDate,
            quantity: quantity
        )
        
        viewModel.addProduct(product)
        dismiss()
    }
}

#Preview {
    AddProductView()
        .environmentObject(ProductViewModel())
} 