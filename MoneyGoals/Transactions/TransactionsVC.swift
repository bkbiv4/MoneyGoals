//
//  TransactionsVC.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 10/17/20.
//

import UIKit
import CoreData

class TransactionsVC: UIViewController {
    
    var transactions = [Transaction]()
    var allTransactions = [[Transaction]]()
    var dateSections = [String]()
    var unsortedDateSections = [String]()
    var accountSections = [String]()
    var sortedDateSections = [String]()
    var dates = [Date]()
    
    
    var transactionTableView : UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkBlue
        return view
    }()
    
    var transactionSearchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search"
        bar.showsCancelButton = true
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        setupNavigationMenuStyle()
        TransactionsVC.menuOpen = false
        fetchTransactions()
        view.backgroundColor = .beige
        TransactionsVC.menuTable = MenuTableVC(TransactionsVC.menuView, self)
        transactionTableView.dataSource = self
        transactionTableView.delegate = self
        transactionTableView.register(TransactionCell.self, forCellReuseIdentifier: "TransactionCell")
        setUI()
    }
    
    func fetchTransactions() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Transaction>(entityName: "Transaction")
            do {
                let transactions = try context.fetch(fetchRequest)
                self.transactions = transactions
            } catch let fetchErr {
                print("Failed to fetch error", fetchErr)
            }
        
        let firstF = DateFormatter()
        firstF.dateFormat = "dd MM, yyyy"// yyyy-MM-dd"
        let secondF = DateFormatter()
        secondF.dateFormat = "EEE, MMMM d"
        
        for transaction in transactions {
            let date = transaction.transactionDate
            let dateString = firstF.string(from: date!)
            dateSections.append(dateString)
        }
        
        for d in dateSections {
            let date = firstF.date(from: d)
            if let date = date {
                dates.append(date)
            }
        }
        
        let sortedDates = dates.sorted(by: { $0.compare($1) == .orderedDescending })
        
        sortedDates.forEach { (date) in
            unsortedDateSections.append(secondF.string(from: date))
        }
        
        sortedDateSections = unsortedDateSections.uniqued()
        
        sortedDateSections.forEach { (type) in
            if type  == secondF.string(from: Date()) {
                accountSections.append("Today")
            }
            
            else if type == secondF.string(from: Date.yesterday) {
                accountSections.append("Yesterday")
            }
            else {
                accountSections.append(type)
            }
        }
        
        sortedDateSections.forEach { (type) in
            allTransactions.append(
                transactions.filter { secondF.string(from: $0.transactionDate!) == type }
            )
        }
    }
    
    
    
    
    
    
    
    
    func setUI() {
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
        
        TransactionsVC.superView.addSubview(transactionTableView)
        transactionTableView.topAnchor.constraint(equalTo: transactionSearchBar.bottomAnchor).isActive = true
        transactionTableView.leftAnchor.constraint(equalTo: TransactionsVC.superView.leftAnchor).isActive = true
        transactionTableView.rightAnchor.constraint(equalTo: TransactionsVC.superView.rightAnchor).isActive = true
        transactionTableView.bottomAnchor.constraint(equalTo: TransactionsVC.superView.bottomAnchor).isActive = true
        
        
    }
}

extension TransactionsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return allTransactions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTransactions[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionCell
        cell.transaction = allTransactions[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return accountSections[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
