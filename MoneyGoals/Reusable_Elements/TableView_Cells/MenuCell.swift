//
//  MenuCell.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 10/14/20.
//

import UIKit

class MenuCell: UITableViewCell {
    
  
    let menuItemLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.font16
        label.textColor = .white
        return label
    }()
    
    var menuDivider : UIView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.tealColor
        
        addSubview(menuItemLabel)
        menuItemLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        menuItemLabel.widthAnchor.constraint(equalToConstant: 160).isActive = true
        menuItemLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        menuItemLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        createDivider()
        
        addSubview(menuDivider)
        menuDivider.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        menuDivider.widthAnchor.constraint(equalToConstant: 5).isActive = true
        menuDivider.topAnchor.constraint(equalTo: topAnchor).isActive = true
        menuDivider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
       

    }
    
    func createDivider() {
        self.menuDivider = createDivider(color: .yellow)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
