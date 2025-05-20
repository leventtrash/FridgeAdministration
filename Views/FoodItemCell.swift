//
//  FoodItemCell.swift
//  FridgeAdministration
//
//  Created by Levent Aydogan on 13.05.25.
//


// FoodItemCell.swift
import UIKit

class FoodItemCell: UITableViewCell {
    private let nameLabel = UILabel()
    private let expiryDateLabel = UILabel()
    private let statusIndicator = UIView()
    private let categoryLabel = UILabel()
    private let quantityLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        // Name Label
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        // Expiry Date Label
        expiryDateLabel.font = UIFont.systemFont(ofSize: 14)
        expiryDateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(expiryDateLabel)
        
        // Status Indicator
        statusIndicator.translatesAutoresizingMaskIntoConstraints = false
        statusIndicator.layer.cornerRadius = 8
        contentView.addSubview(statusIndicator)
        
        // Category Label
        categoryLabel.font = UIFont.systemFont(ofSize: 12)
        categoryLabel.textColor = .systemGray
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(categoryLabel)
        
        // Quantity Label
        quantityLabel.font = UIFont.systemFont(ofSize: 14)
        quantityLabel.textAlignment = .right
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(quantityLabel)
        
        NSLayoutConstraint.activate([
            statusIndicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            statusIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            statusIndicator.widthAnchor.constraint(equalToConstant: 16),
            statusIndicator.heightAnchor.constraint(equalToConstant: 16),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: statusIndicator.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: quantityLabel.leadingAnchor, constant: -12),
            
            expiryDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            expiryDateLabel.leadingAnchor.constraint(equalTo: statusIndicator.trailingAnchor, constant: 12),
            
            categoryLabel.topAnchor.constraint(equalTo: expiryDateLabel.bottomAnchor, constant: 4),
            categoryLabel.leadingAnchor.constraint(equalTo: statusIndicator.trailingAnchor, constant: 12),
            categoryLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12),
            
            quantityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            quantityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func configure(with item: FoodItem) {
        nameLabel.text = item.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        expiryDateLabel.text = "MHD: \(dateFormatter.string(from: item.expiryDate)) (\(item.daysUntilExpiry) Tage)"
        
        statusIndicator.backgroundColor = item.status.color
        categoryLabel.text = item.category.rawValue
        quantityLabel.text = "x\(item.quantity)"
        
        // Textfarbe für MHD basierend auf Status
        switch item.status {
        case .expired:
            expiryDateLabel.textColor = .systemRed
        case .expiringSoon:
            expiryDateLabel.textColor = .systemOrange
        case .good:
            expiryDateLabel.textColor = .systemGray
        }
    }
}
