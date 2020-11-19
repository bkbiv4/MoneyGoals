//
//  CreditCell.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 10/22/20.
//

import UIKit

class CreditCell: UITableViewCell {
    
    var account: Account? {
        didSet {
            brokerName.text = account?.broker?.brokerName
            accountName.text = account?.accountName
            
            let creditB = convertDTS(amount: ((account?.accountBalance)!).roundTo(places: 2))
//            let creditL = convertDTS(amount: ((account?.credit?.creditLimit)!).roundTo(places: 2))
            let creditU = convertDTS(amount: ((((account?.accountBalance)!)/((account?.credit?.creditLimit)!)))*100)
            
            creditBalance.text = "BALANCE \n \n $\(creditB)"
            creditLimit.text = "USAGE \n \n \(creditU)%"
        }
    }
    
    let accountNameView: DesignableView = {
        let view = DesignableView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.font = UIFont.font16
        view.cornerRadius = 5
        view.backgroundColor = .white
        return view
    }()
    
    var brokerName: UILabel!
    var accountName: UILabel!
    var creditBalance: UILabel!
    var creditLimit: UILabel!
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.darkBlue
        
        let margins = layoutMarginsGuide
        
        addSubview(accountNameView)
        accountNameView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        accountNameView.widthAnchor.constraint(equalToConstant: 110).isActive = true
        accountNameView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        accountNameView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        
        brokerName = createLabel(string: "", font: UIFont.font12, color: .black, alignment: .left)
        
        let nameMargins = accountNameView.layoutMarginsGuide
        
        accountNameView.addSubview(brokerName)
        brokerName.leadingAnchor.constraint(equalTo: nameMargins.leadingAnchor).isActive = true
        brokerName.trailingAnchor.constraint(equalTo: nameMargins.trailingAnchor).isActive = true
        brokerName.topAnchor.constraint(equalTo: accountNameView.topAnchor).isActive = true
        brokerName.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        accountName = createLabel(string: "", font: UIFont.font12, color: .black, alignment: .left)
        
        accountNameView.addSubview(accountName)
        accountName.leadingAnchor.constraint(equalTo: nameMargins.leadingAnchor).isActive = true
        accountName.trailingAnchor.constraint(equalTo: nameMargins.trailingAnchor).isActive = true
        accountName.bottomAnchor.constraint(equalTo: accountNameView.bottomAnchor).isActive = true
        accountName.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        let remainingWidth = self.frame.width - accountNameView.frame.width
        let labelWidth = remainingWidth / 2
        
        creditBalance = createLabel(string: "BALANCE", font: UIFont.font12, color: .white, alignment: .center)
        
        addSubview(creditBalance)
        creditBalance.leftAnchor.constraint(equalTo: accountNameView.rightAnchor).isActive = true
        creditBalance.widthAnchor.constraint(equalToConstant: labelWidth).isActive = true
        creditBalance.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        creditBalance.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        creditLimit = createLabel(string: "LIMIT", font: UIFont.font12, color: .white, alignment: .center)
        
        
        addSubview(creditLimit)
        creditLimit.leftAnchor.constraint(equalTo: creditBalance.rightAnchor).isActive = true
        creditLimit.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        creditLimit.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        creditLimit.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        creditBalance.numberOfLines = 3
        creditLimit.numberOfLines = 3
        
        layoutIfNeeded()
       

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
