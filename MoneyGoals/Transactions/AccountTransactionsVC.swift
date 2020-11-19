//
//  AccountTransactionsVC.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 11/5/20.
//

import UIKit
import CoreData
import UniformTypeIdentifiers

class AccountTransactionsVC: UIViewController {
    
    var account: Account?
    var transactions = [Transaction]()
    var csvFile: [[String]]?
    var dateSections = [String]()
    var dates = [Date]()
    var accountTransacions = [Transaction]()
    var accountSections = [String]()
    var sortedDateSections = [String]()
    var unsortedDateSections = [String]()
    var allAccountTransactions = [[Transaction]]()
    
    var transactionTableView : UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkBlue
        return view
    }()
    
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
        
        for x in transactions {
            if x.account == self.account {
                accountTransacions.append(x)
            }
        }
        
        for transaction in accountTransacions {
            let date = transaction.transactionDate
            let dateString = firstF.string(from: date!)
            dateSections.append(dateString)
        }
            
        for dat in dateSections {
            let date = firstF.date(from: dat)
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
            allAccountTransactions.append(
                transactions.filter { secondF.string(from: $0.transactionDate!) == type }
            )
        }
//        print(allAccountTransactions)
        
        print(allAccountTransactions.count)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationStyle()
        self.title = "Transactions"
        
        fetchTransactions()
        
        view.backgroundColor = .brown
        setupPlusIcon(#selector(addTransaction))
        setupCancelButton()
        
        setUI()
        
        transactionTableView.dataSource = self
        transactionTableView.delegate = self
        transactionTableView.register(TransactionCell.self, forCellReuseIdentifier: "TransactionCell")
        
        
        
    }
    
    @objc func addTransaction() {
        let transactionCreationOptions = UIAlertController(title: "Add Transaction(s)", message: "Add a new transaction or import a csv", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        /// - Note: Fix this Part
        let importAction = UIAlertAction(title: "Import CSV", style: .default) { (action) in
            /// - Note: Set up Plaid Linking
            print("Linking")
            let fileType: [UTType] = [UTType.commaSeparatedText]  /// - Note: This restricts the imported file types to Common Seperated Values
            /// - Note: - Create a custom document picker to add cancel button
            
            let csvPicker = UIDocumentPickerViewController(forOpeningContentTypes: fileType, asCopy: true) /// - Note: This allows the user to select the csv from ther files app
            csvPicker.delegate = self
            csvPicker.allowsMultipleSelection = false

            let navcontoller = CustomNavigationController(rootViewController: csvPicker)
            navcontoller.modalPresentationStyle = .fullScreen
            navcontoller.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(self.handleCancelModal))
            self.present(navcontoller, animated: true, completion: nil)
        }
            
        let manualAction = UIAlertAction(title: "Add Transaction", style: .default) { (action) in
            let createTransaction = CreateTransactionVC()
//            createAccount.delegate = self
            createTransaction.account = self.account
            let navController = CustomNavigationController(rootViewController: createTransaction)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        }
        
        transactionCreationOptions.addAction(cancelAction)
        transactionCreationOptions.addAction(importAction)
        transactionCreationOptions.addAction(manualAction)
        
        transactionCreationOptions.pruneNegativeWidthConstraints()
        
        self.present(transactionCreationOptions, animated: true)
    }
    
    func setUI() {
        
        view.addSubview(transactionTableView)
        transactionTableView.heightAnchor.constraint(equalToConstant: 600).isActive = true
//        transactionTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        transactionTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        transactionTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        transactionTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

extension AccountTransactionsVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allAccountTransactions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allAccountTransactions[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionCell
        cell.transaction = allAccountTransactions[indexPath.section][indexPath.row]
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

extension AccountTransactionsVC: UIDocumentPickerDelegate {
   
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {

        guard let myURL = urls.first else {
            return
        }
        //        print("import result : \(myURL)")
        let data = handleCSVFile(url: myURL)
        csvFile = data

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"

        

        for columns in csvFile! {
            
            if columns.count == 4 {
//                var tuple: (Transaction?, Error?)
                if columns == ["Date", "Description", "Amount", "Running Bal."] {
                }
                else {
                    let transactionDate = columns[0]
                    let transactionDescription = columns[1]
                    let transactionAmount = Double(columns[2]) ?? 0.0
                    print(transactionAmount)
                    var transactionType: String!
                    var amount: Double = 0.0
                    
                    if transactionAmount < 0 {
                        transactionType = "Expense"
                        amount = transactionAmount * -1
                    }
                    else if transactionAmount > 0 {
                        transactionType = "Income"
                        amount = transactionAmount
                    }
                    
                    let accountBalance = account?.accountBalance
                    
                    if transactionType == "Income" {
                        self.account?.accountBalance = accountBalance! + amount
                    }
                    else if transactionType == "Expense" {
                        account?.accountBalance = accountBalance! - amount
                    }
                    
//                    transaction = Transaction(transactionDate: dateFormatter.date(from: transactionDate)!, transactionDescription: transactionDescription, transactionAmount: transactionAmount)
//                    print(transaction)

                    let tuple = CoreDataManager.shared.createTransaction(account: self.account!, transactionDate: dateFormatter.date(from: transactionDate)!, transactionType: transactionType, transactionDescription: transactionDescription, transactionValue: amount, mainCategory: "Uncategorized", subCategory: "Uncategorized")
//
                    if let error = tuple.1 {
                        print(error)
                    }
//
                    else {
                        // creation success
//                        dismiss(animated: true, completion: {
                            // we'll call the delegate somehow
                        print(tuple.0!)
//                            self.delegate?.createAccount(account: tuple.0!)
//                        })
                    }
                }
            }
        }
    }
   
       func handleCSVFile(url: URL) -> [[String]] {
           if let data = try? String(contentsOf: url) {
               var result: [[String]] = []
               let rows = data.components(separatedBy: "\r\n")
               for row in rows {
                   let columns = row.components(separatedBy: ",")
                   var cells: [String] = []
   
                   for item in columns {
                       let cell = item.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range:nil)
                       if cell != "" {
                           cells.append(cell)
                       }
                   }
   
                   // Only append the array if it's not empty
                   if cells != [] {
                       result.append(cells)
                   }
               }
   
               // Double check that the array doesn't contain any empty entries
               for i in 0 ..< result.count {
                   if result[i] == [] {
                       result.remove(at: i)
                   }
               }
   
               return result
           } else {
               return [[]]
           }
       }
    
//    func setUI() {
//        view.addSubview(TransactionsVC.superView)
//        TransactionsVC.superView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        TransactionsVC.superView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        TransactionsVC.superView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        TransactionsVC.superView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        
//        TransactionsVC.superView.addSubview(transactionTable)
//        transactionTable.leftAnchor.constraint(equalTo: InventoryVC.superView.leftAnchor).isActive = true
//        transactionTable.topAnchor.constraint(equalTo: InventoryVC.superView.topAnchor).isActive = true
//        transactionTable.rightAnchor.constraint(equalTo: InventoryVC.superView.rightAnchor).isActive = true
//        transactionTable.bottomAnchor.constraint(equalTo: InventoryVC.superView.bottomAnchor).isActive = true
//    }

}


extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}

public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter{ seen.insert($0).inserted }
    }
}
