//
//  AccountCell.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 10/22/20.
//

import UIKit

class AccountCell: UITableViewCell {
    
    var account: Account? {
        didSet {
            brokerName.text = account?.broker?.brokerName
            accountName.text = account?.accountName

            let accountB = convertDTS(amount: ((account?.accountBalance)!).roundTo(places: 2))

            accoountBalance.text = "BALANCE \n \n $\(accountB)"
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
    var accoountBalance: UILabel!
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let margins = layoutMarginsGuide
        
        backgroundColor = UIColor.darkBlue
        
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

        accoountBalance = createLabel(string: "BALANCE", font: UIFont.font12, color: .white, alignment: .center)

        addSubview(accoountBalance)
        accoountBalance.leftAnchor.constraint(equalTo: accountNameView.rightAnchor).isActive = true
        accoountBalance.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        accoountBalance.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        accoountBalance.topAnchor.constraint(equalTo: topAnchor).isActive = true

        accoountBalance.numberOfLines = 3

        layoutIfNeeded()
       

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
