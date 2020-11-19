//
//  MenuTableVC.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 10/14/20.
//

import UIKit

class MenuTableVC: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    /// - Note : This code is used to present the Menu when the Menu Button is pressed on the selected Page
    
    var tableView: UITableView
    var vC : UIViewController
    var menuOptions: [String]
    
    /// - Note: This variable will be used the user has access to all Fiance Options
    var allMenuOptions : [String] = ["Overview", "All Accounts", "All Transactions", "Budgets", "Bills", "Credit Cards", "Forex P/L Calcualtor", "Paycheck Tracker", "Settings"]
    
    /// - Note: This varible will be used when the user only has access to the basic FInance Options
    var baseMenuOptions: [String] = ["Accounts", "All Transactions"]
    
    var specialOptions: [String] = ["Overview", "Accounts", "All Transactions", "Bills", "Inventory"]
    
    init(_ tv: UITableView, _ vc: UIViewController) {
        
        menuOptions = baseMenuOptions
        
        vC = vc
        tableView = tv
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
        
        tv.backgroundColor = .darkBlue
        
        tableView.register(MenuCell.self, forCellReuseIdentifier: "menuCell")
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuCell
        cell.menuItemLabel.text = menuOptions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        if menuOptions[indexPath.row] == "Overview" {
//            let vc = Overview_View_Controller()
//            let navController = CustomNavigationController(rootViewController: vc)
//            navController.modalPresentationStyle = .fullScreen
//            vC.present(navController, animated: true, completion: nil)
//        }
        
//        if menuOptions[indexPath.row] == "Accounts" {
//            let vc = AccountsVC()
//            let navController = CustomNavigationController(rootViewController: vc)
//            navController.modalPresentationStyle = .fullScreen
//            vC.present(navController, animated: true, completion: nil)
//        }
        
        if menuOptions[indexPath.row] == "All Transactions" {
//            let vc = TransactionsVC()
//            let navController = CustomNavigationController(rootViewController: vc)
//            navController.modalPresentationStyle = .fullScreen
//            vC.present(navController, animated: true, completion: nil)
        }
        
        if menuOptions[indexPath.row] == "Bills" {
            let vc = BillsVC()
            let navController = CustomNavigationController(rootViewController: vc)
            navController.modalPresentationStyle = .fullScreen
            vC.present(navController, animated: true, completion: nil)
        }
        
        if menuOptions[indexPath.row] == "Inventory" {
            let vc = InventoryVC()
            let navController = CustomNavigationController(rootViewController: vc)
            navController.modalPresentationStyle = .fullScreen
            vC.present(navController, animated: true, completion: nil)
        }
    }
    
}
