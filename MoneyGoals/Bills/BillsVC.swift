//
//  BillsVC.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 10/17/20.
//

import UIKit
import CoreData

protocol CreateBillsVCD {
    func createBill(_ bill: Bill)
    func editBill(_ bill: Bill)
}

class BillsVC: UIViewController {
    
    var bills = [Bill]()
    var allBills = [[Bill]]()
    var billSections : [String] = []
    
    func fetchBills() {
        createBillSections()
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Bill>(entityName: "Bill")
            do {
                let bills = try context.fetch(fetchRequest)
                self.bills = bills
            } catch let fetchErr {
                print("Failed to fetch error", fetchErr)
            }
        
        allBills = []

        billSections.forEach { (type) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM yyyy"
            allBills.append(
                bills.filter { dateFormatter.string(from: $0.billDate!) == type }
            )
        }
        print(allBills)
//        billTable.tableView.reloadData()
    }
    
    
    func createBillSections() {
        let today = Date()
        var datecomponent = DateComponents()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        
        for x in 0...36 {
            datecomponent.month = x
            let newMonth = Calendar.current.date(byAdding: datecomponent, to: today)!
            let dateString = dateFormatter.string(from: newMonth)
            billSections.append(dateString)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Bills"
        
        fetchBills()
        
        billTable = BillTable(billTableView, allBills, self, billSections)
        setupPlusIcon(#selector(addBill))
        setUI()
    }
    
    @objc func addBill() {
        print("Adding Bill")
        
        let creatbillVC = CreateBillVC()
        creatbillVC.modalPresentationStyle = .pageSheet
        creatbillVC.modalTransitionStyle = .crossDissolve
        creatbillVC.delegate = self
        let height = self.view.bounds.size.height
        let width = self.view.bounds.size.width
        
        creatbillVC.preferredContentSize = CGSize(width: width * 0.6, height: height * 0.6)
        creatbillVC.accessibilityFrame = CGRect(x: 0, y: 0, width: width * 0.6, height: height * 0.6)
        
        present(creatbillVC, animated: true, completion: nil)
    }
    
    var billTable: BillTable!
    
    var billTableView : UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    func setUI() {
        
        
        view.addSubview(billTable.tableView)
        billTable.tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        billTable.tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        billTable.tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        billTable.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
}

extension BillsVC: CreateBillsVCD {
    func createBill(_ bill: Bill) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        guard let section = billSections.firstIndex(of: dateFormatter.string(from: bill.billDate!)) else { return }
        let row = allBills[section].count

        let insertionIndexPath = IndexPath(row: row, section: section)

        allBills[section].append(bill)

        billTable.tableView.insertRows(at: [insertionIndexPath], with: .middle)
//        fetchBills()
        billTable.tableView.reloadData()
    }
    
    func editBill(_ bill: Bill) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        
        guard let section = billSections.firstIndex(of: dateFormatter.string(from: bill.billDate!)) else { return }
        let newIndexPath = IndexPath(row: allBills[section].count - 1, section: section)
        billTable.tableView.reloadRows(at: [newIndexPath], with: .automatic)
//        fetchBills()
        billTable.tableView.reloadData()
    }
}
