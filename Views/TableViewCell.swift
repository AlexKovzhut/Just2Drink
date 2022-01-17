//
//  TableViewCell.swift
//  Just2Drink
//
//  Created by Alexander Kovzhut on 08.01.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    // MARK: - Public properties
    static let identifier = "identifier"
    
    let titleLabel = UILabel()
    let detaillabel = UILabel()
    
    // MARK: - UITableViewCell Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setStyle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setStyle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.shadowColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.text = "Title"
        
        detaillabel.translatesAutoresizingMaskIntoConstraints = false
        detaillabel.textColor = UIColor.black
        detaillabel.shadowColor = UIColor.black
        detaillabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        detaillabel.text = "Detail"
    }
        
    private func setLayout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(detaillabel)
            
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            
            detaillabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            detaillabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    func configure(with drink: Drink) {
        titleLabel.text = drink.strDrink
        detaillabel.text = drink.strCategory
    }
}
