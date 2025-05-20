import SwiftUI
import AVFoundation

struct ScanView: View {
    @EnvironmentObject private var viewModel: ProductViewModel
    @StateObject private var cameraManager = CameraManager()
    @State private var isScanning = false
    @State private var showingAddProduct = false
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            VStack {
                if isScanning {
                    CameraPreview(cameraManager: cameraManager)
                        .onAppear {
                            cameraManager.startScanning()
                        }
                        .onDisappear {
                            cameraManager.stopScanning()
                        }
                        .onChange(of: cameraManager.scannedBarcode) { barcode in
                            if let barcode = barcode {
                                showingAddProduct = true
                            }
                        }
                } else {
                    VStack(spacing: 20) {
                        Image(systemName: "barcode.viewfinder")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                        
                        Text("Tippe zum Scannen")
                            .font(.headline)
                        
                        Button(action: { isScanning = true }) {
                            Text("Scanner starten")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .navigationTitle("Barcode scannen")
            .sheet(isPresented: $showingAddProduct) {
                if let barcode = cameraManager.scannedBarcode {
                    AddProductView(barcode: barcode)
                }
            }
            .alert("Fehler", isPresented: $showingError) {
                Button("OK", role: .cancel) {}
            } message: {
                if let error = cameraManager.error {
                    Text(error.localizedDescription)
                }
            }
            .onChange(of: cameraManager.error) { error in
                showingError = error != nil
            }
        }
    }
}

struct CameraPreview: UIViewRepresentable {
    let cameraManager: CameraManager
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        cameraManager.setupPreviewLayer(in: view)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

#Preview {
    ScanView()
        .environmentObject(ProductViewModel())
} 