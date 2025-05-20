import SwiftUI

struct InventoryView: View {
    @EnvironmentObject private var viewModel: ProductViewModel
    @State private var showingAddProduct = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.getSortedProducts()) { product in
                    ProductRow(product: product)
                }
                .onDelete(perform: deleteProducts)
            }
            .navigationTitle("Inventar")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddProduct = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddProduct) {
                AddProductView()
            }
        }
    }
    
    private func deleteProducts(at offsets: IndexSet) {
        let products = viewModel.getSortedProducts()
        offsets.forEach { index in
            viewModel.removeProduct(products[index])
        }
    }
}

struct ProductRow: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(product.name)
                    .font(.headline)
                Spacer()
                Text("\(product.quantity)x")
                    .foregroundColor(.secondary)
            }
            
            HStack {
                Text(product.expirationDate.formatted(date: .abbreviated, time: .omitted))
                    .font(.subheadline)
                    .foregroundColor(expirationColor)
                
                if product.isExpiringSoon {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.yellow)
                }
            }
        }
        .padding(.vertical, 4)
    }
    
    private var expirationColor: Color {
        if product.isExpired {
            return .red
        } else if product.isExpiringSoon {
            return .orange
        } else {
            return .green
        }
    }
}

#Preview {
    InventoryView()
        .environmentObject(ProductViewModel())
} 