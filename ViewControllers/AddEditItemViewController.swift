//
//  AddEditItemViewController.swift
//  FridgeAdministration
//
//  Created by Levent Aydogan on 13.05.25.
//


// AddEditItemViewController.swift
import UIKit

class AddEditItemViewController: UIViewController {
    private var nameTextField: UITextField!
    private var barcodeTextField: UITextField!
    private var scanBarcodeButton: UIButton!
    private var expiryDatePicker: UIDatePicker!
    private var quantityTextField: UITextField!
    private var categorySegmentedControl: UISegmentedControl!
    private var notesTextView: UITextView!
    private var saveButton: UIButton!
    
    private var item: FoodItem?
    
    // Für Bearbeitung eines vorhandenen Artikels
    convenience init(item: FoodItem) {
        self.init()
        self.item = item
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = item == nil ? "Neues Lebensmittel" : "Lebensmittel bearbeiten"
        
        setupUI()
        
        if let item = item {
            // Feld mit vorhandenen Daten füllen
            nameTextField.text = item.name
            barcodeTextField.text = item.barcode
            expiryDatePicker.date = item.expiryDate
            quantityTextField.text = String(item.quantity)
            if let index = FoodCategory.allCases.firstIndex(of: item.category) {
                categorySegmentedControl.selectedSegmentIndex = index
            }
            notesTextView.text = item.notes
        }
    }
    
    private func setupUI() {
        // Name
        nameTextField = UITextField()
        nameTextField.placeholder = "Produktname"
        nameTextField.borderStyle = .roundedRect
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        
        // Barcode
        barcodeTextField = UITextField()
        barcodeTextField.placeholder = "Barcode"
        barcodeTextField.borderStyle = .roundedRect
        barcodeTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(barcodeTextField)
        
        // Scan-Button
        scanBarcodeButton = UIButton(type: .system)
        scanBarcodeButton.setTitle("Barcode scannen", for: .normal)
        scanBarcodeButton.addTarget(self, action: #selector(scanBarcode), for: .touchUpInside)
        scanBarcodeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scanBarcodeButton)
        
        // MHD-Datepicker
        expiryDatePicker = UIDatePicker()
        expiryDatePicker.datePickerMode = .date
        expiryDatePicker.preferredDatePickerStyle = .wheels
        expiryDatePicker.translatesAutoresizingMaskIntoConstraints = false
        expiryDatePicker.minimumDate = Date()
        view.addSubview(expiryDatePicker)
        
        // Menge
        quantityTextField = UITextField()
        quantityTextField.placeholder = "Menge"
        quantityTextField.borderStyle = .roundedRect
        quantityTextField.keyboardType = .numberPad
        quantityTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quantityTextField)
        
        // Kategorie
        let categories = FoodCategory.allCases.map { $0.rawValue }
        categorySegmentedControl = UISegmentedControl(items: categories)
        categorySegmentedControl.selectedSegmentIndex = 0
        categorySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categorySegmentedControl)
        
        // Notizen
        notesTextView = UITextView()
        notesTextView.layer.borderColor = UIColor.systemGray4.cgColor
        notesTextView.layer.borderWidth = 1.0
        notesTextView.layer.cornerRadius = 5.0
        notesTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(notesTextView)
        
        // Speichern-Button
        saveButton = UIButton(type: .system)
        saveButton.setTitle("Speichern", for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 10
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.addTarget(self, action: #selector(saveItem), for: .touchUpInside)
        view.addSubview(saveButton)
        
        // Constraints
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            barcodeTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            barcodeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            barcodeTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6, constant: -20),
            
            scanBarcodeButton.centerYAnchor.constraint(equalTo: barcodeTextField.centerYAnchor),
            scanBarcodeButton.leadingAnchor.constraint(equalTo: barcodeTextField.trailingAnchor, constant: 10),
            scanBarcodeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            expiryDatePicker.topAnchor.constraint(equalTo: barcodeTextField.bottomAnchor, constant: 20),
            expiryDatePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            expiryDatePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            expiryDatePicker.heightAnchor.constraint(equalToConstant: 200),
            
            quantityTextField.topAnchor.constraint(equalTo: expiryDatePicker.bottomAnchor, constant: 20),
            quantityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            quantityTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            categorySegmentedControl.topAnchor.constraint(equalTo: quantityTextField.bottomAnchor, constant: 20),
            categorySegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categorySegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            notesTextView.topAnchor.constraint(equalTo: categorySegmentedControl.bottomAnchor, constant: 20),
            notesTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            notesTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            notesTextView.heightAnchor.constraint(equalToConstant: 100),
            
            saveButton.topAnchor.constraint(equalTo: notesTextView.bottomAnchor, constant: 30),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func scanBarcode() {
        let scanner = BarcodeScannerViewController()
        scanner.barcodeDetectedHandler = { [weak self] barcode in
            self?.barcodeTextField.text = barcode
            // Hier könnte man eine API-Abfrage machen, um Produktinformationen zu erhalten
        }
        present(scanner, animated: true)
    }
    
    @objc private func saveItem() {
        guard let name = nameTextField.text, !name.isEmpty,
              let barcode = barcodeTextField.text,
              let quantityString = quantityTextField.text, let quantity = Int(quantityString) else {
            showAlert(title: "Fehler", message: "Bitte alle Pflichtfelder ausfüllen.")
            return
        }
        
        let categoryIndex = categorySegmentedControl.selectedSegmentIndex
        let category = FoodCategory.allCases[categoryIndex]
        
        if let existingItem = item {
            // Bestehendes Item aktualisieren
            let updatedItem = FoodItem(
                id: existingItem.id,
                name: name,
                barcode: barcode,
                expiryDate: expiryDatePicker.date,
                quantity: quantity,
                category: category,
                notes: notesTextView.text
            )
            FoodItemStore.shared.updateFoodItem(updatedItem)
        } else {
            // Neues Item hinzufügen
            let newItem = FoodItem(
                name: name,
                barcode: barcode,
                expiryDate: expiryDatePicker.date,
                quantity: quantity,
                category: category,
                notes: notesTextView.text
            )
            FoodItemStore.shared.addFoodItem(newItem)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
