//
//  Inventory_Item_Cell.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 10/18/20.
//

import UIKit

class InventoryItemCell: UITableViewCell {
    
    var item : Inventory? {
        didSet {
            itemLabel.text = item?.itemName
            
            itemQuanity.text = "\((item?.itemAmount)!) \((item?.itemName)!) Remaining"
        }
    }
    
    
    

    let itemLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.font16
        label.textColor = .white
        return label
    }()
    
    let itemQuanity: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.font16
        label.textColor = .white
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.tealColor
        
        addSubview(itemLabel)
        itemLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        itemLabel.widthAnchor.constraint(equalToConstant: 160).isActive = true
        itemLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        itemLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        addSubview(itemQuanity)
        itemQuanity.heightAnchor.constraint(equalToConstant: 30).isActive = true
        itemQuanity.widthAnchor.constraint(equalToConstant: 350).isActive = true
        itemQuanity.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        itemQuanity.topAnchor.constraint(equalTo: itemLabel.bottomAnchor).isActive = true
        
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
