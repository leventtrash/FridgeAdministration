//
//  FoodItemListViewController.swift
//  FridgeAdministration
//
//  Created by Levent Aydogan on 13.05.25.
//


// FoodItemListViewController.swift
import UIKit

class FoodItemListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var tableView: UITableView!
    private var segmentedControl: UISegmentedControl!
    private var searchBar: UISearchBar!
    private var foodItems: [FoodItem] = []
    private var filteredItems: [FoodItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Kühlschrank Manager"
        view.backgroundColor = .systemBackground
        
        setupUI()
        
        // Benachrichtigungsberechtigung anfordern
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Fehler beim Anfordern der Benachrichtigungsberechtigung: \(error)")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFoodItems()
    }
    
    private func setupUI() {
        // Segmentierungssteuerung für Filterung
        segmentedControl = UISegmentedControl(items: ["Alle", "Bald ablaufend", "Abgelaufen"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(filterItems), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        // Suchleiste
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Suchen..."
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        // Tabelle
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FoodItemCell.self, forCellReuseIdentifier: "FoodItemCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        // Constraints
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            searchBar.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // + Button hinzufügen
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewItem)
        )
    }
    
    @objc private func addNewItem() {
        let addItemVC = AddEditItemViewController()
        navigationController?.pushViewController(addItemVC, animated: true)
    }
    
    private func loadFoodItems() {
        foodItems = FoodItemStore.shared.loadFoodItems()
        filterItems()
    }
    
    @objc private func filterItems() {
        switch segmentedControl.selectedSegmentIndex {
        case 0: // Alle
            filteredItems = foodItems
        case 1: // Bald ablaufend
            filteredItems = foodItems.filter { $0.status == .expiringSoon }
        case 2: // Abgelaufen
            filteredItems = foodItems.filter { $0.status == .expired }
        default:
            filteredItems = foodItems
        }
        
        // Wenn eine Suche aktiv ist, filtern wir zusätzlich nach dem Suchtext
        if let searchText = searchBar.text, !searchText.isEmpty {
            filteredItems = filteredItems.filter { item in
                return item.name.lowercased().contains(searchText.lowercased()) ||
                       item.barcode.lowercased().contains(searchText.lowercased())
            }
        }
        
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodItemCell", for: indexPath) as! FoodItemCell
        let item = filteredItems[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = filteredItems[indexPath.row]
        let editVC = AddEditItemViewController(item: item)
        navigationController?.pushViewController(editVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Löschen") { [weak self] (_, _, completion) in
            guard let self = self else { return }
            
            let item = self.filteredItems[indexPath.row]
            FoodItemStore.shared.deleteFoodItem(with: item.id)
            self.loadFoodItems() // Neu laden und filtern
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
extension FoodItemListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterItems()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
