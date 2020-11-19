//
//  CreateTransactionVC.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 11/5/20.
//

import UIKit

class CreateTransactionVC: UIViewController {
    
    var account: Account?
    var delegate: CreateTransactionVCD?
    
    let transactionTypeControl : UISegmentedControl = {
        let types = [
            TransactionType.Income.rawValue,
            TransactionType.Transfer.rawValue,
            TransactionType.Expense.rawValue
            
        ]
        let sc = UISegmentedControl(items: types)
        sc.selectedSegmentIndex = 0
        sc.apportionsSegmentWidthsByContent = true
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.layer.backgroundColor = .coral
        return sc
    }()
    
    let transactionDescriptionText : UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont.font16
        field.textAlignment = .center
//        field.text = "Transaction Description"
        field.placeholder = "Transaction Description"
        return field
    }()
    
    let transactionValueText : CurrencyField = {
        let field = CurrencyField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont.font16
        field.awakeFromNib()
        field.textAlignment = .center
        return field
    }()
    
    let transactionDateText : UITextField = {
        let today = Date()
        let dF = DateFormatter()
        dF.dateFormat = "MM/dd/yyyy"
        
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont.font16
        field.placeholder = dF.string(from: today)
        field.textAlignment = .center
        return field
    }()
    
    var datePicker : UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.datePickerStyle == .wheels
        return dp
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationStyle()
        view.backgroundColor = .brown
        setupPlusIcon(#selector(savetransaction))
        
        transactionDateText.inputView = datePicker
        setUI()
        
        
    }
    
    @objc func savetransaction() {
        guard let transactionDescription = transactionDescriptionText.text else { return}
        guard let transactionType = transactionTypeControl.titleForSegment(at: transactionTypeControl.selectedSegmentIndex) else {return}
        let transactionValue = -convertStringToCurrency(input: transactionValueText.text!)!
        
        let accountBalance = account?.accountBalance
        
        if transactionType == "Income" {
            account?.accountBalance = accountBalance! + transactionValue
        }
        else if transactionType == "Expense" {
            account?.accountBalance = accountBalance! - transactionValue
        }
        
        let dF = DateFormatter()
        dF.dateFormat = "MM/dd/yyyy"
        
        let tuple = CoreDataManager.shared.createTransaction(account: account!, transactionDate: dF.date(from: transactionDateText.text!)!, transactionType: transactionType, transactionDescription: transactionDescription, transactionValue: transactionValue, mainCategory: "Uncategorized", subCategory: "Uncategorized")
        
        
        
        if let error = tuple.1 {
            print("Failed due to \(error)")
        }
        
        else {
            dismiss(animated: true) {
                self.delegate?.createTransaction(transaction: tuple.0!)
            }
        }
    }
    
    func setUI() {
        view.addSubview(transactionTypeControl)
        transactionTypeControl.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        transactionTypeControl.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        transactionTypeControl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        transactionTypeControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(transactionDescriptionText)
        transactionDescriptionText.topAnchor.constraint(equalTo: transactionTypeControl.bottomAnchor, constant: 20).isActive = true
        transactionDescriptionText.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        transactionDescriptionText.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        transactionDescriptionText.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(transactionDateText)
        transactionDateText.topAnchor.constraint(equalTo: transactionDescriptionText.bottomAnchor, constant: 20).isActive = true
        transactionDateText.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        transactionDateText.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        transactionDateText.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(transactionValueText)
        transactionValueText.topAnchor.constraint(equalTo: transactionDateText.bottomAnchor, constant: 20).isActive = true
        transactionValueText.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        transactionValueText.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        transactionValueText.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
