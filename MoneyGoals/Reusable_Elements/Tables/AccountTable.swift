//
//  AssetTableVC.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 10/18/20.
//

import CoreData
import UIKit

class AccountTable: NSObject, UITableViewDelegate, UITableViewDataSource, CreateAccountVCD {
    
    func createAccount(account: Account) {
        guard let section = accountTypes.firstIndex(of: (account.accountType?.mainType)!) else { return }
        // what is my row?
        let row = accounts[section].count

        let insertionIndexPath = IndexPath(row: row, section: section)
        accounts[section].append(account)
        tableView.insertRows(at: [insertionIndexPath], with: .middle)
        
        
        tableView.reloadData()
        
        print(tableView.frame)
        
    }
        
    func editAccount(account: Account) {
        guard let section = accountTypes.firstIndex(of: (account.accountType?.mainType)!) else { return }
        let newIndexPath = IndexPath(row: accounts[section].count - 1, section: section)
        tableView.reloadRows(at: [newIndexPath], with: .automatic)
    }
    
    
    /// - Note : This code is used to present the Menu when the Menu Button is pressed on the selected Page
    var accountTypes: [String] = ["Assets", "Credit", "Investments", "Loans", "Other"]
    var tableView: UITableView
    var vC : UIViewController
    
    var accounts = [[Account]]()
    
    

                
    
    /// - Note: This variable will be used the user has access to all Fiance Options
//    var allMenuOptions : [String] =
    
    init(_ tv: UITableView, _ ats: [[Account]], _ vc: UIViewController) {
        
        vC = vc
        
        accounts = ats
        tableView = tv
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
        
        tv.backgroundColor = .darkBlue
        
        tableView.register(AccountCell.self, forCellReuseIdentifier: "AccountCell")
        tableView.register(CreditCell.self, forCellReuseIdentifier: "CreditCell")
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return acountTypes[section]
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var totalArray : [Double] = []
        var total : Double = 0.0
        
        let type = accountTypes[section]
        
        for a in accounts {
            for account in a {
                let accountType = account.accountType?.mainType
                
                if type == accountType {
                    totalArray.append(account.accountBalance)
                }
            }
        }
        
        totalArray.forEach { (value) in
            total += value
        }
        
        let actions: [Selector] = [#selector(addAssetAction), #selector(addCreditAction), #selector(addInvestmentAction), #selector(addLoanAction), #selector(addOtherAction)]
        
        let headerView = UIView()
        headerView.backgroundColor = .darkBlue
        
        let label: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = " \(accountTypes[section])         $\(total)"
//            label.text = accountTypes[section]
            label.font = UIFont.font18
            label.textColor = .white
            return label
        }()
        let button : UIButton = {
            let button = UIButton()
            button.tag = section
            button.setImage(UIImage(systemName: "plus"), for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: actions[section], for: .touchUpInside)
            return button
        }()
        
        let headerMargins = headerView.layoutMarginsGuide
        
        headerView.addSubview(label)
        label.leadingAnchor.constraint(equalTo: headerMargins.leadingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: headerMargins.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        headerView.addSubview(button)
        button.trailingAnchor.constraint(equalTo: headerMargins.trailingAnchor).isActive = true
        button.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true

        return headerView
    }
    
    @objc func addAssetAction() {
        print("Adding Asset")
        let createassetVC = CreateAssetVC()
        createassetVC.modalPresentationStyle = .popover
        createassetVC.modalTransitionStyle = .crossDissolve
        createassetVC.delegate = self
        let height = vC.view.bounds.size.height
        let width = vC.view.bounds.size.width
        
        createassetVC.preferredContentSize = CGSize(width: width * 0.6, height: height * 0.6)
        
        vC.present(createassetVC, animated: true, completion: nil)
    }
    @objc func addCreditAction() {
        print("Adding Credit")
        let createCreditVC = CreateCreditVC()
        createCreditVC.modalPresentationStyle = .popover
        createCreditVC.modalTransitionStyle = .crossDissolve
        createCreditVC.delegate = self
//        let height = vC.view.bounds.size.height
//        let width = vC.view.bounds.size.width
        
//        createCreditVC.preferredContentSize = CGSize(width: width * 0.6, height: height * 0.6)
        
        vC.present(createCreditVC, animated: true, completion: nil)
    }
    @objc func addInvestmentAction() {
        print("Adding Investment")
        let createInvestmentVC = CreateInvestmentVC()
        createInvestmentVC.modalPresentationStyle = .popover
        createInvestmentVC.modalTransitionStyle = .crossDissolve
        createInvestmentVC.delegate = self
        let height = vC.view.bounds.size.height
        let width = vC.view.bounds.size.width
        
        createInvestmentVC.preferredContentSize = CGSize(width: width * 0.6, height: height * 0.6)
        
        vC.present(createInvestmentVC, animated: true, completion: nil)
    }
    @objc func addLoanAction() {
        print("Adding Loan")
        let createLoanVC = CreateLoanVC()
        createLoanVC.modalPresentationStyle = .popover
        createLoanVC.modalTransitionStyle = .crossDissolve
        createLoanVC.delegate = self
        let height = vC.view.bounds.size.height
        let width = vC.view.bounds.size.width
        
        createLoanVC.preferredContentSize = CGSize(width: width * 0.6, height: height * 0.6)
        
        vC.present(createLoanVC, animated: true, completion: nil)
}
    @objc func addOtherAction() {
        print("Adding Other")
        let createOtherVC = CreateOtherVC()
        createOtherVC.modalPresentationStyle = .popover
        createOtherVC.modalTransitionStyle = .crossDissolve
        createOtherVC.delegate = self
        let height = vC.view.bounds.size.height
        let width = vC.view.bounds.size.width
        
        createOtherVC.preferredContentSize = CGSize(width: width * 0.6, height: height * 0.6)
        
        vC.present(createOtherVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if accounts[section].count == 0 {
            return 70
        }
        else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.accounts[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CreditCell", for: indexPath) as! CreditCell
            cell.account = accounts[indexPath.section][indexPath.row]
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath) as! AccountCell
            cell.account = accounts[indexPath.section][indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if accounts[section].count == 0 {
            let footerView : DesignableView = {
                let view = DesignableView()
                view.cornerRadius = 10
                view.cornerRadius = 10
                view.backgroundColor = .accountFooterColor
                return view
            }()
            let label: UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.textColor = .white
                label.text = "Click to Add Here"
                label.textAlignment = .center
                return label
            }()
        
            let margins = footerView.layoutMarginsGuide
            
            footerView.addSubview(label)
            label.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
            label.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
            label.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
            label.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
            
            return footerView
        }
        else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let accountView = AccountSingularVC()
        accountView.modalPresentationStyle = .formSheet
        accountView.modalTransitionStyle = .crossDissolve
        
        let account = self.accounts[indexPath.section][indexPath.row]
        accountView.account = account
//        createOtherVC.delegate = self
        
//        accountView.preferredContentSize = CGSize(width: width * 0.6, height: height * 0.6)
        
        vC.present(accountView, animated: true, completion: nil)
    }

}




