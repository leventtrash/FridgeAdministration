//
//  BarcodeScannerView.swift
//  FridgeAdministration
//
//  Created by Levent Aydogan on 18.02.25.
//


import SwiftUI
import AVFoundation

struct BarcodeScannerView: UIViewControllerRepresentable {
    @Binding var scannedCode: String
    
    func makeUIViewController(context: Context) -> ScannerVC {
        let scanner = ScannerVC()
        scanner.delegate = context.coordinator
        return scanner
    }
    
    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: BarcodeScannerView
        
        init(_ parent: BarcodeScannerView) {
            self.parent = parent
        }
        
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject, let code = metadataObject.stringValue {
                DispatchQueue.main.async {
                    self.parent.scannedCode = code
                }
            }
        }
    }
}

class ScannerVC: UIViewController {
    var delegate: AVCaptureMetadataOutputObjectsDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        let session = AVCaptureSession()
        
        guard let device = AVCaptureDevice.default(for: .video) else {
            print("❌ Keine Kamera verfügbar oder Zugriff verweigert")
            return
        }
        
        guard let input = try? AVCaptureDeviceInput(device: device) else {
            print("❌ Kamera-Input konnte nicht erstellt werden")
            return
        }

        let output = AVCaptureMetadataOutput()

        session.addInput(input)
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
        output.metadataObjectTypes = [.ean13, .ean8, .upce]
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.layer.bounds
        view.layer.addSublayer(previewLayer)
        
        session.startRunning()
    }
}
