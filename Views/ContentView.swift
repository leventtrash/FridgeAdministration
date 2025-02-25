import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FridgeContentView()
                .tabItem {
                    Label("Kühlschrank", systemImage: "house.fill")
                }
            
            BarcodeScannerView()
                .tabItem {
                    Label("Scanner", systemImage: "qrcode.viewfinder")
                }
            
            ProductListView()
                .tabItem {
                    Label("Inventar", systemImage: "list.bullet")
                }
        }
    }
}

#Preview {
    ContentView()
}
