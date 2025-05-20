import SwiftUI

struct MainTabView: View {
    @StateObject private var productViewModel = ProductViewModel()
    
    var body: some View {
        TabView {
            InventoryView()
                .tabItem {
                    Label("Inventar", systemImage: "list.bullet")
                }
            
            ScanView()
                .tabItem {
                    Label("Scannen", systemImage: "barcode.viewfinder")
                }
            
            SettingsView()
                .tabItem {
                    Label("Einstellungen", systemImage: "gear")
                }
        }
        .environmentObject(productViewModel)
    }
}

#Preview {
    MainTabView()
} 