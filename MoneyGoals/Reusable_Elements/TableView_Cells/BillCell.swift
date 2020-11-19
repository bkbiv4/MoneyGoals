//
//  BillCell.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 11/7/20.
//

import UIKit

class BillCell: UITableViewCell {
    
    var bill: Bill? {
        didSet {
            billNameLabel.text = bill?.billName
            let value = bill?.billValue
            billValueLabel.text = convertCTS(amount: value!)
//
//            // MARK: - Set Up Date Parameters
//
            // Date Format for Bill Date Label
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "ccc, MMM dd, yyy"

            guard let billDate = bill?.billDate else { return  }
            let dateString = dateFormatter.string(from: billDate)
            billDateLabel.text = dateString
//
            //Calculation for Days Left Label
            let today = Date()
//            let todayDate = today.date
            let secondsBetween: TimeInterval = billDate.timeIntervalSince(today)
            let numberOfDays: Int = lround((secondsBetween / 86400))

            daysLabel.text = "\(numberOfDays) days"

            if numberOfDays >= 7 {
                daysLabel.backgroundColor = .accountFooterColor
            }
            else if numberOfDays < 7 && numberOfDays > 0 {
                daysLabel.backgroundColor = .yellow
            }
            else if numberOfDays <= 0 {
                daysLabel.backgroundColor = .systemRed
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
  
    let billNameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.font20;
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let billDateLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.font20;
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let billValueLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.font20;
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let daysLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .navigationBarColor
        label.textAlignment = .center
        label.font = UIFont.font24;
        label.baselineAdjustment = .alignCenters
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.tealColor
        
        let margins = layoutMarginsGuide
        
        addSubview(daysLabel)
        daysLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        daysLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        daysLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        daysLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(billNameLabel)
        billNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        billNameLabel.widthAnchor.constraint(equalToConstant: 160).isActive = true
        billNameLabel.leftAnchor.constraint(equalTo: daysLabel.rightAnchor, constant: 5).isActive = true
        billNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        
        addSubview(billDateLabel)
        billDateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        billDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        billDateLabel.widthAnchor.constraint(equalToConstant: 160).isActive = true
        billDateLabel.leftAnchor.constraint(equalTo: daysLabel.rightAnchor, constant: 5).isActive = true
//        billDateLabel.topAnchor.constraint(equalTo: billNameLabel.bottomAnchor).isActive = true
        
        addSubview(billValueLabel)
//        billValueLabel.topAnchor.constraint(equalTo: billDateLabel.topAnchor).isActive = true
        billValueLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        billValueLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        billValueLabel.centerYAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
//        billValueLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
