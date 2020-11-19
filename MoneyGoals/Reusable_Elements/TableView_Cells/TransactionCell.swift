//
//  TransactionCell.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 11/7/20.
//

import UIKit

class TransactionCell: UITableViewCell {
    
    var transaction : Transaction? {
        didSet {
            transactionDescriptionLabel.text = transaction?.transactionDescription
            let balance = transaction?.transactionValue
            transactionValueLabel.text = convertCTS(amount: balance!)
            transactionCategoryLabel.text = transaction?.category?.subCategory
            
            if transaction?.transactionType == "Income" {
                transactionValueLabel.textColor = .green
            }
            else if transaction?.transactionType == "Expense" {
                transactionValueLabel.textColor = .red
            }
        }
    }

    let transactionDescriptionLabel: UILabel = {
        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.font14
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    let transactionValueLabel: UILabel = {
        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.font14
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()
    
    let transactionCategoryLabel: UILabel = {
        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.font14
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.darkBlue
        
        let margin = layoutMarginsGuide
        
        let stack : UIStackView = {
            let stack = UIStackView()
            stack.addArrangedSubview(transactionDescriptionLabel)
            stack.addArrangedSubview(transactionCategoryLabel)
            stack.addArrangedSubview(transactionValueLabel)
            stack.axis = .horizontal
            stack.distribution = .fillEqually
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        
        addSubview(stack)
        stack.leftAnchor.constraint(equalTo: margin.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: margin.rightAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: topAnchor).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

