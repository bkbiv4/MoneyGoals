//
//  Transactions_View_Controller.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 10/17/20.
//

//import UIKit
//
//import Foundation
//import UIKit
//import CoreData
//import UniformTypeIdentifiers
//
//class TransactionsVC: UIViewController {
//
//    var transactions = [Transaction]()
//    var csvFile: [[String]]?
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//
//        setupNavigationStyle()
//        
//        self.transactions = CoreDataManager.shared.fetchTransaction()
//        
//        setupNavigationMenuStyle()
//        TransactionsVC.menuOpen = false
//        
//        transactionTable.delegate = self
//        transactionTable.dataSource = self
//        transactionTable.register(TransactionCell.self, forCellReuseIdentifier: "TransactionCell")
//
//        let image = UIImage(systemName: "square.and.arrow.up")
//        image?.withTintColor(UIColor.darkBlue)
//        
//        setUI()
//
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(scaleSelected))
//    }
//    
//    
//   
//    var transactionTable : UITableView = {
//        let table = UITableView()
//        table.backgroundColor = .darkBlue
//        table.translatesAutoresizingMaskIntoConstraints = false
//        return table
//    }()
//   
//   
//   
//    @objc func scaleSelected() {
//   
//       let fileType: [UTType] = [UTType.commaSeparatedText]  /// - Note: This restricts the imported file types to Common Seperated Values
//       let csvPicker = UIDocumentPickerViewController(forOpeningContentTypes: fileType, asCopy: true) /// - Note: This allows the user to select the csv from ther files app
//       csvPicker.delegate = self
//       csvPicker.allowsMultipleSelection = false
//
//       let navcontoller = CustomNavigationController(rootViewController: csvPicker)
//       navcontoller.modalPresentationStyle = .fullScreen
//       present(navcontoller, animated: true, completion: nil)
//   }
//}
//   
//   
//   
//   
//extension TransactionsVC: UIDocumentPickerDelegate {
//   
//    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//
//        guard let myURL = urls.first else {
//            return
//        }
//        //        print("import result : \(myURL)")
//        let data = handleCSVFile(url: myURL)
//        csvFile = data
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM/dd/yyyy"
//
//        
//
//        for columns in csvFile! {
//            
//            if columns.count == 4 {
//                var transaction: Transaction?
//                if columns == ["Date", "Description", "Amount", "Running Bal."] {
//                    transaction = nil
//                }
//                else {
//                    let transactionDate = columns[0]
//                    let transactionDescription = columns[1]
//                    let transactionAmount = Double(columns[2]) ?? 0.0
//                    var transactionType: String!
//                    
//                    if transactionAmount < 0 {
//                        transactionType = "Expense"
//                    }
//                    else if transactionAmount > 0 {
//                        transactionType = "Income"
//                    }
//                    
////                    transaction = Transaction(transactionDate: dateFormatter.date(from: transactionDate)!, transactionDescription: transactionDescription, transactionAmount: transactionAmount)
////                    print(transaction)
//
////                    let tuple = CoreDataManager.shared.{}}(transactionDate: dateFormatter.date(from: transactionDate)!, transactionType: transactionType, transactionDescription: transactionDescription, transactionValue: transactionAmount, mainCategory: "Uncategorized", subCategory: "Uncategorized")
////                    
////                    if let error = tuple.1 {
////                        print(error)
////                    }
////
////                    else {
////                        // creation success
//////                        dismiss(animated: true, completion: {
////                            // we'll call the delegate somehow
////                            print(tuple.0!)
//////                            self.delegate?.createAccount(account: tuple.0!)
//////                        })
////                    }
//                }
//            }
//        }
//    }
//   
//       func handleCSVFile(url: URL) -> [[String]] {
//           if let data = try? String(contentsOf: url) {
//               var result: [[String]] = []
//               let rows = data.components(separatedBy: "\r\n")
//               for row in rows {
//                   let columns = row.components(separatedBy: ",")
//                   var cells: [String] = []
//   
//                   for item in columns {
//                       let cell = item.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range:nil)
//                       if cell != "" {
//                           cells.append(cell)
//                       }
//                   }
//   
//                   // Only append the array if it's not empty
//                   if cells != [] {
//                       result.append(cells)
//                   }
//               }
//   
//               // Double check that the array doesn't contain any empty entries
//               for i in 0 ..< result.count {
//                   if result[i] == [] {
//                       result.remove(at: i)
//                   }
//               }
//   
//               return result
//           } else {
//               return [[]]
//           }
//       }
//    
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
//
//}
//
//extension TransactionsVC: UITableViewDelegate, UITableViewDataSource {
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        inventory.count
//        print(transactions.count)
//        return transactions.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionCell
//        let transaction = transactions[indexPath.row]
////        print(type(of: cell.transaction))
////        print(type(of: transaction))
//        
//        
//        cell.transaction = transaction
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
//    
//}
