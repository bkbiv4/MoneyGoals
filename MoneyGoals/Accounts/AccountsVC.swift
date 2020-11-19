//
//  Accounts_View_Controller.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 10/17/20.
//

import UIKit
import CoreData
import Charts

protocol CreateAccountVCD {
    // - Note : This function will handle the creation of Assets
    func createAccount(account: Account)
    // - Note : This function will handle the editing of Assets
    func editAccount(account: Account)
}


class AccountsVC: UIViewController {
    
    var mainAccountTypes = [
        MainAccountCategories.Assets.rawValue,
        MainAccountCategories.Credit.rawValue,
        MainAccountCategories.Investments.rawValue,
        MainAccountCategories.Loans.rawValue,
        MainAccountCategories.Other.rawValue,
    ]
    var accounts = [Account]()
    var transactions = [Transaction]()
    var allAccounts = [[Account]]()
    var networth = 0.0
    var dayNetworth = 0.0
    var todayNetworth = 0.0
    var addedNetworth = 0.0
    var dayNetworthArray : [Double] = []
    var yValues : [ChartDataEntry] = []
    var networthDates: [String] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Accounts"
        view.backgroundColor = .darkBlue
        setupNavigationMenuStyle()
        AccountsVC.menuOpen = false
//        deleteTransactions()
        fetchTransactions()
        
        self.accounts = CoreDataManager.shared.fetchAccounts()
        sortAccounts()
        createChartData()
        chartViewDidLoad()
        AccountsVC.menuTable = MenuTableVC(AccountsVC.menuView, self)
        setUI()
    }
    
    func chartViewDidLoad() {
        chartView.delegate = self
        chartView.xAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        chartView.legend.enabled = false
        chartView.animate(xAxisDuration: 1)
    }
    
    func deleteTransactions() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Transaction>(entityName: "Transaction")
        do {
            let transactions = try context.fetch(fetchRequest)
            self.transactions = transactions
            for x in transactions {
                context.delete(x)
                try context.save()
            }
        }
        catch let fetchErr {
            print("Failed to fetch error", fetchErr)
        }
    }
    
    func fetchTransactions() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Transaction>(entityName: "Transaction")
        do {
            let transactions = try context.fetch(fetchRequest)
            self.transactions = transactions
        }
        catch let fetchErr {
            print("Failed to fetch error", fetchErr)
        }
    }
    
    func sortAccounts() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Account>(entityName: "Account")
        do {
            let accounts = try context.fetch(fetchRequest)
            self.accounts = accounts
            self.accountTableView.reloadData()
        }
        catch let fetchErr {
            print("Failed to fetch error", fetchErr)
        }
            
        allAccounts = []
        
        mainAccountTypes.forEach { (type) in
            allAccounts.append(
                accounts.filter{ $0.accountType?.mainType == type }
            )
        }
//        accountTable.tableView.reloadData()
    }

    var accountTable : AccountTable!
    var accountTableView : UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkBlue
        return view
    }()

    let chartView: LineChartView = {
        let label = LineChartView()
//        label.text = "Scroll Bottom"
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var chartNetworthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font22
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func calculateNetworth() {
        for account in accounts {
            if account.accountType?.mainType == "Assets" || account.accountType?.mainType == "Investments" {
                networth += account.accountBalance
            }
            else if account.accountType?.mainType == "Credit" || account.accountType?.mainType == "Loans" {
                networth -= account.accountBalance
            }
            
        }
    }
    
    func createChartData() {
        for account in accounts {
            if account.accountType?.mainType == "Assets" || account.accountType?.mainType == "Investments" {
                networth += account.accountBalance
            }
            else if account.accountType?.mainType == "Credit" || account.accountType?.mainType == "Loans" {
                networth -= account.accountBalance
            }

        }
        
        let secondF = DateFormatter()
        secondF.dateFormat = "MM/dd/yyyy"
        
        let today = "04/30/2020"
        
        
        for x in 0...30 {
            networthDates.append(secondF.string(from: Calendar.current.date(byAdding: .day, value: -x, to: secondF.date(from: today)!)!))
        }
        
        for y in networthDates {
            dayNetworth = 0.0
            for x in transactions {
                if secondF.string(from: x.transactionDate!) == y {
                    if x.transactionType == "Income" {
                        dayNetworth += x.transactionValue
                    }
                    else if x.transactionType == "Expense" {
                        dayNetworth -= x.transactionValue
                    }
                }
            }
            
            dayNetworthArray.append(dayNetworth.roundTo(places: 2))
        }
        
        print(dayNetworthArray, "Day Array")
        
        addedNetworth = 0.0
        todayNetworth = Double(dayNetworthArray.count)
        print(todayNetworth, "Today Net")
        
        yValues.append(ChartDataEntry(x: 31, y: networth))
        
        for x in dayNetworthArray {
            addedNetworth += x
            todayNetworth -= 1.0
            yValues.append(ChartDataEntry(x: todayNetworth, y: networth + addedNetworth))
        }
        yValues.reverse()
        
        let dataSet = LineChartDataSet(entries: yValues, label: "Networth")
//        dataSet.drawCircleHoleEnabled = false
        dataSet.drawCirclesEnabled = false
        dataSet.mode = .linear
        
        let data = LineChartData(dataSet: dataSet)
        data.setDrawValues(false)
        chartView.data = data
        
    }
    
    func setUI() {
        accountTable = AccountTable(accountTableView, allAccounts, self)
        
//        let screensize: CGRect = UIScreen.main.bounds
//        let screenWidth = screensize.width
//        var footers = CGFloat(0.0)
//
//        for footer in allAccounts {
//            if footer == [] {
//                footers += 1
//            }
//        }
//
//        let cellHeight = CGFloat(accounts.count * 90)/*Height of Cells*/
//        let footerHeight = CGFloat(footers * 70)/*Height of Footers*/
//        let tableHeight = 150/*Height of Headers*/ + footerHeight + cellHeight
//        let viewHeight = self.view.frame.height - 500
//        let screenHeight = tableHeight + viewHeight
        
        view.addSubview(AccountsVC.superView)
        AccountsVC.superView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        AccountsVC.superView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        AccountsVC.superView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        AccountsVC.superView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        
        let margin = AccountsVC.superView.layoutMarginsGuide
        
        AccountsVC.superView.addSubview(mainView)
        mainView.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
        mainView.topAnchor.constraint(equalTo: margin.topAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: margin.trailingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: margin.bottomAnchor).isActive = true
        
        mainView.addSubview(chartView)
        chartView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        chartView.leftAnchor.constraint(equalTo: mainView.leftAnchor).isActive = true
        chartView.rightAnchor.constraint(equalTo: mainView.rightAnchor).isActive = true
        chartView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        chartView.addSubview(chartNetworthLabel)
        chartNetworthLabel.text = convertCurrencyToString(amount: networth)
        
        mainView.addSubview(accountTable.tableView)
        accountTable.tableView.leftAnchor.constraint(equalTo: mainView.leftAnchor).isActive = true
        accountTable.tableView.rightAnchor.constraint(equalTo: mainView.rightAnchor).isActive = true
        accountTable.tableView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
        accountTable.tableView.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 10).isActive = true
        
        

    }

}

extension AccountsVC: ChartViewDelegate {
    
    func chartViewDidEndPanning(_ chartView: ChartViewBase) {
        chartView.reloadInputViews()
    }

    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(convertCurrencyToString(amount: entry.y))
        
        chartNetworthLabel.text = convertCurrencyToString(amount: entry.y)
    }
    
//    func setData() {
//        var data = LineChartData(dataSet: LineChartDataSet(entries: yValues, label: "Networth"))
//        chartView.data = data
//    }
    
}
