//
//  BillTable.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 10/29/20.
//

import UIKit
import CoreData

class BillTable: NSObject, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView
    var vC : UIViewController
    var bills = [[Bill]]()
    var sections = [String]()
    
    
    init(_ tv: UITableView, _ bill: [[Bill]], _ vc: UIViewController, _ section: [String]) {
        vC = vc
        bills = bill
        sections = section
        tableView = tv
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
        
        tv.backgroundColor = .darkBlue
        
        tableView.register(BillCell.self, forCellReuseIdentifier: "BillCell")
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return bills.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bills[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BillCell", for: indexPath) as! BillCell
        cell.bill = bills[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, view, _) in
            let bill = self.bills[indexPath.section][indexPath.row]
            print("Trying to Delete Finance Account...", bill.billName ?? "")
            
            let context = CoreDataManager.shared.persistentContainer.viewContext
            
//            for transaction in account.transactions! {
//                context.delete(transaction as! NSManagedObject)
//            }
            
            //remove firm from tableview
            self.bills.remove(at: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
            
            //remove all transactions from account before account deletion
//            guard let accountTransactions = account.transactions?.allObjects as? [Transaction] else {return}
//            accountTransactions.forEach { (transaction) in
//                context.delete(transaction)
//            }

            //remove  from Core Data
            
            context.delete(bill)
            do {
                try context.save()
                self.tableView.reloadData()
            }
            catch let saveErr {
                print("Failed to delete firm:", saveErr)
            }
        }
        
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (_, view, _) in
            
//            let editVC = CreateBillVC()
//            editVC.delegate = self
//            editVC.bill = self.bills[indexPath.section][indexPath.row]
//            let navController = UINavigationController(rootViewController: editVC)
//            navController.modalPresentationStyle = .fullScreen
//            self.vC.present(navController, animated: true, completion: nil)
            
            let creatbillVC = CreateBillVC()
            creatbillVC.modalPresentationStyle = .pageSheet
            creatbillVC.modalTransitionStyle = .crossDissolve
            creatbillVC.bill = self.bills[indexPath.section][indexPath.row]
            creatbillVC.delegate = self
            let height = self.vC.view.bounds.size.height
            let width = self.vC.view.bounds.size.width
            
            creatbillVC.preferredContentSize = CGSize(width: width * 0.6, height: height * 0.6)
            creatbillVC.accessibilityFrame = CGRect(x: 0, y: 0, width: width * 0.6, height: height * 0.6)
            
            self.vC.present(creatbillVC, animated: true, completion: nil)
            
        }
        
        deleteAction.backgroundColor = .red
        
        let swipeAction = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        swipeAction.performsFirstActionWithFullSwipe = false
        return swipeAction
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if bills[section].count == 0 {
            return 0
        }
        else {
            return 30
        }
    }
    
}

extension BillTable: CreateBillsVCD {
    func createBill(_ bill: Bill) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        guard let section = sections.firstIndex(of: dateFormatter.string(from: bill.billDate!)) else { return }
        let row = bills[section].count

        let insertionIndexPath = IndexPath(row: row, section: section)

        bills[section].append(bill)

        tableView.insertRows(at: [insertionIndexPath], with: .middle)
//        fetchBills()
        tableView.reloadData()
    }
    
    func editBill(_ bill: Bill) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        
        guard let section = sections.firstIndex(of: dateFormatter.string(from: bill.billDate!)) else { return }
        let newIndexPath = IndexPath(row: bills[section].count - 1, section: section)
        tableView.reloadRows(at: [newIndexPath], with: .automatic)
//        fetchBills()
        tableView.reloadData()
    }
}
