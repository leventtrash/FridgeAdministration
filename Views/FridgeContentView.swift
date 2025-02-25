import SwiftUI

struct FridgeContentView: View {
    @State private var products: [Product] = []
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("🔍 Suche", text: .constant(""))
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    Button(action: {}) {
                        Image(systemName: "slider.horizontal.3")
                            .padding()
                            .background(Color(.systemGray6))
                            .clipShape(Circle())
                    }
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        Button(action: {}) {
                            Text("⭐ Favoriten")
                        }
                        .buttonStyle(.bordered)
                        
                        Button(action: {}) {
                            Text("⏳ Verlauf")
                        }
                        .buttonStyle(.bordered)
                        
                        Button(action: {}) {
                            Text("📦 Inventar")
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding(.horizontal)
                }
                
                List(products) { product in
                    HStack {
                        AsyncImage(url: URL(string: product.imageUrl))
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        VStack(alignment: .leading) {
                            Text(product.name).font(.headline)
                            Text("Marke: \(product.brand)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("Ablaufdatum: \(product.expiryDate)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Button(action: { deleteProduct(product) }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
                Spacer()
            }
            .navigationTitle("Kühlschrank")
        }
    }
    
    func deleteProduct(_ product: Product) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products.remove(at: index)
        }
    }
}

#Preview {
    FridgeContentView()
}
