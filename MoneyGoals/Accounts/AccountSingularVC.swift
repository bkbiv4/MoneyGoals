//
//  AccountSingularVC.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 11/5/20.
//

import UIKit
import Charts

class AccountSingularVC: UIViewController {
    
    var transactions = [Transaction]()
    
    var account : Account? {
        didSet {
            accountType.text = account?.accountType?.subType
            let balance = convertCurrencyToString(amount: account!.accountBalance)
            balanceLabel.text = " BALANCE \n \(balance)"
        }
    }
    
    var accountType: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.font16
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var transactionLabel: UILabel = {
        let label = UILabel()
        label.text = "TRANSACTIONS"
        label.font = UIFont.font16
        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var editLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "EDIT"
        label.font = UIFont.font16
//        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var deleteLabel: UILabel = {
        let label = UILabel()
        label.text = "DELETE"
        label.textAlignment = .center
        label.font = UIFont.font16
//        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var transactionGraph : LineChartView = {
        let view = LineChartView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var balanceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.font16
        label.numberOfLines = 2
//        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .abbey
        view.layer.cornerRadius = 25
        setUI()
        
    }
    
//    func grabTransactions() {
//        for 0...4 in transactions {
//            
//        }
//    }
    
    override func viewDidLayoutSubviews() {
        let height = view.bounds.size.height
        let width = view.bounds.size.width
        self.view.frame = CGRect(x: 0, y: height - 500, width: width, height: 500)
    }
    
    @objc func openTrans(sender: UITapGestureRecognizer) {
        print("Opening Transactions")
        let accountTransactions = AccountTransactionsVC()
//        createAccount.delegate = self
        accountTransactions.account = account
        let navController = CustomNavigationController(rootViewController: accountTransactions)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func edit(sender: UITapGestureRecognizer) {
        let editVC = CreateAssetVC()
//        createAccount.delegate = self
        editVC.account = account
        let navController = CustomNavigationController(rootViewController: editVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func deleteAccount(sender: UITapGestureRecognizer) {
        let account = self.account
        print("Trying to Delete...", account?.accountName ?? "")
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
            
//        for transaction in account!.transactions {
//            context.delete(transaction as! NSManagedObject)
//        }
//
            //remove firm from tableview
//            self.accounts[indexPath.section].remove(at: indexPath.row)
            
//            self.tableView.deleteRows(at: [indexPath], with: .automatic)
//            tableView.reloadData()
            
            //remove all transactions from account before account deletion
        guard let accountTransactions = account?.transactions?.allObjects as? [Transaction] else {return}
        accountTransactions.forEach { (transaction) in
            context.delete(transaction)
        }

            //remove  from Core Data
            
        context.delete(account!)
        do {
            try context.save()
//            self.tableView.reloadData()
        }
        catch let saveErr {
            print("Failed to delete firm:", saveErr)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func updateBalance() {
        
    }
    
    func setUI() {
        setChart()
        let margin = view.layoutMarginsGuide
        
        view.addSubview(accountType)
        accountType.leftAnchor.constraint(equalTo: margin.leftAnchor).isActive = true
        accountType.rightAnchor.constraint(equalTo: margin.rightAnchor).isActive = true
        accountType.topAnchor.constraint(equalTo: margin.topAnchor).isActive = true
        accountType.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        transactionLabel.isUserInteractionEnabled = true
        let openTransactions = UITapGestureRecognizer(target: self, action: #selector(openTrans))
        transactionLabel.addGestureRecognizer(openTransactions)
        
        editLabel.isUserInteractionEnabled = true
        let editGesture = UITapGestureRecognizer(target: self, action: #selector(edit))
        editLabel.addGestureRecognizer(editGesture)
        
        deleteLabel.isUserInteractionEnabled = true
        let deleteGesture = UITapGestureRecognizer(target: self, action: #selector(deleteAccount))
        deleteLabel.addGestureRecognizer(deleteGesture)
        
        let buttonStackView : UIStackView = {
            let stack = UIStackView()
            stack.addArrangedSubview(editLabel)
            stack.addArrangedSubview(transactionLabel)
            stack.addArrangedSubview(deleteLabel)
            stack.axis = .horizontal
            stack.backgroundColor = .accountFooterColor
            stack.distribution = .fillEqually
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        let infoStackView : UIStackView = {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .horizontal
            stack.addArrangedSubview(balanceLabel)
            stack.backgroundColor = .accountFooterColor
            return stack
        }()
        
        
        view.addSubview(buttonStackView)
        buttonStackView.leftAnchor.constraint(equalTo: margin.leftAnchor).isActive = true
        buttonStackView.rightAnchor.constraint(equalTo: margin.rightAnchor).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        buttonStackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(transactionGraph)
        transactionGraph.leftAnchor.constraint(equalTo: margin.leftAnchor).isActive = true
        transactionGraph.rightAnchor.constraint(equalTo: margin.rightAnchor).isActive = true
        transactionGraph.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -20).isActive = true
        transactionGraph.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        view.addSubview(infoStackView)
        infoStackView.leftAnchor.constraint(equalTo: margin.leftAnchor).isActive = true
        infoStackView.rightAnchor.constraint(equalTo: margin.rightAnchor).isActive = true
        infoStackView.bottomAnchor.constraint(equalTo: transactionGraph.topAnchor, constant: -20).isActive = true
        infoStackView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
    }
}

extension AccountSingularVC: ChartViewDelegate {
    
    
    
    func setChart() {
        chartViewDidLoad()
        createChartData()
    }
    func chartViewDidLoad() {
        transactionGraph.delegate = self
        transactionGraph.xAxis.enabled = false
        transactionGraph.leftAxis.enabled = false
        transactionGraph.rightAxis.enabled = false
        transactionGraph.legend.enabled = false
        transactionGraph.animate(xAxisDuration: 1)
    }
    
    func createChartData() {
        var graphDates: [String] = []
        var dailyChange: Double = 0.0
        var dailyChangeArray: [Double] = []
        var finalArray : [Double] = []
        var yValues : [ChartDataEntry] = []
        var week = 7.0
        var month = 30.0
        var threeMonth = 90.0
        var sixMonth = 180.0
        
        guard let transactions = self.account?.transactions?.allObjects as? [Transaction] else {return}
        guard var currentBalance = self.account?.accountBalance else {return}
        
        
        var accountBalanceArray : [Double] = [currentBalance]
        
        let secondF = DateFormatter()
        secondF.dateFormat = "MM/dd/yyyy"
        
        let today = Date()
        
        for x in stride(from: 0.0, to: month, by: 1) {
            graphDates.append(secondF.string(from: Calendar.current.date(byAdding: .day, value: Int(-x), to: secondF.date(from: secondF.string(from: today))!)!))
        }
        graphDates.reverse()
        
        for date in graphDates {
            dailyChange = 0.0
            for x in transactions {
                if secondF.string(from: x.transactionDate!) == date {
                    dailyChange += x.transactionValue
                }
            }
            dailyChangeArray.append(dailyChange)
        }
        
        dailyChangeArray.reverse()
        
        for x in dailyChangeArray {
            currentBalance -= x
            accountBalanceArray.append(currentBalance)
        }
        
        finalArray = Array(accountBalanceArray.prefix(Int(month + 1)))
        finalArray.reverse()
        
        
        /// - Note: Final Data Creation
        
        var day = 0.0
        
        for x in finalArray {
            yValues.append(ChartDataEntry(x: day, y: x))
            day += 1.0
        }
        
        
        let dataSet = LineChartDataSet(entries: yValues, label: "Networth")
        dataSet.drawCirclesEnabled = false
        
        let data = LineChartData(dataSet: dataSet)
        data.setDrawValues(false)
        
        transactionGraph.data = data
        
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
        
//        let graphPoint = chartView.getMarkerPosition(entry: entry,  highlight: highlight)

        // Adding top marker
//        markerView.valueLabel.text = "\(entry.value)"
//        markerView.dateLabel.text = "\(months[entry.xIndex])"
//        markerView.center = CGPointMake(graphPoint.x, markerView.center.y)
//        markerView.hidden = false
    }
    
//    func chartView(_ chartView: ChartViewBase, animatorDidStop animator: Animator) {
//        <#code#>
//    }
}
