//
//  TransactionsVC.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 10/17/20.
//

import UIKit

class TransactionsVC: UIViewController {
    
    var transactionSearchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search"
        bar.showsCancelButton = true
//        bar.showsScopeBar = true
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigationMenuStyle()
        TransactionsVC.menuOpen = false
        view.backgroundColor = .beige
        TransactionsVC.menuTable = MenuTableVC(TransactionsVC.menuView, self)
        setUI()
    }
    
    func setUI() {
        view.subviews.forEach { $0.removeFromSuperview() }
        TransactionsVC.superView.subviews.forEach { $0.removeFromSuperview() }
        
        view.addSubview(TransactionsVC.superView)
        TransactionsVC.superView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        TransactionsVC.superView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        TransactionsVC.superView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        TransactionsVC.superView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        TransactionsVC.superView.addSubview(transactionSearchBar)
        transactionSearchBar.leftAnchor.constraint(equalTo: TransactionsVC.superView.leftAnchor).isActive = true
        transactionSearchBar.rightAnchor.constraint(equalTo: TransactionsVC.superView.rightAnchor).isActive = true
        transactionSearchBar.topAnchor.constraint(equalTo: TransactionsVC.superView.topAnchor).isActive = true
    }
}
