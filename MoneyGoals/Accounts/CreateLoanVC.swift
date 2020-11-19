//
//  CreateLoanVC.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 10/22/20.
//

import UIKit

class CreateLoanVC: UIViewController {
    
    var delegate: CreateAccountVCD?
    
    var account: Account?
    
    var creditLabel: UILabel!
    var brokerText: UITextField!
    var accountText: UITextField!
    var keyboardH: CGFloat!
    
    var accountBalance: CurrencyField!
    var accountNumber: UITextField!
    
    let pickerToolBar : UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        toolbar.barStyle = .default
        toolbar.barTintColor = .black
        toolbar.backgroundColor = .white
        toolbar.isTranslucent = false
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(cancelNumberPad))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action:
            #selector(doneWithNumberPad))
        doneButton.tintColor = UIColor.white
        
        toolbar.items = [cancelButton, flexSpace, doneButton]
        
        return toolbar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .accountFooterColor
//        self.definesPresentationContext = true
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        setUI()
    }
    
    @objc func cancelNumberPad() {
        
    }
    @objc func doneWithNumberPad() {
        guard let accountBroker = brokerText.text else {return}
        guard let accountName = accountText.text else {return}
        guard let accountNumber = accountNumber.text else {return}
        
        let accountBalance = convertStringToCurrency(input: self.accountBalance.text!)!
        
        
        let accountTuple = CoreDataManager.shared.createAccountLoan(accountName: accountName, accountBroker: accountBroker, accountST: "Loan", accountBalance: accountBalance, accountNumber: accountNumber)
        
        if let error = accountTuple.1 {
            print(error)
        }

        else {
            // creation success
            dismiss(animated: true, completion: {
                // we'll call the delegate somehow
                print(accountTuple.0!)
                self.delegate?.createAccount(account: accountTuple.0!)
            })
        }
    }
    
    override func viewWillLayoutSubviews() {
//        let height = view.bounds.size.height
        let width = view.bounds.size.width
        
    
        
        self.view.frame = CGRect(x: 0, y: 100, width: width, height: 300)
        
        
    }

    func setUI() {
        creditLabel = createLabel(string: "Manual Credit Card", font: UIFont.font18, color: .black, alignment: .center)
        
        brokerText = createTextField(placeholder: "Bank Name", font: UIFont.font22, alignment: .center, color: .white)
        brokerText.becomeFirstResponder()
        
        accountText = createTextField(placeholder: "Card Name", font: UIFont.font22, alignment: .center, color: .black)
        accountBalance = createCurrencyField(placeholder: "0.00", font: UIFont.font22, alignment: .center)
        accountNumber = createTextField(placeholder: "0000", font: UIFont.font22, alignment: .center, color: .black)
        
        brokerText.inputAccessoryView = pickerToolBar
        accountText.inputAccessoryView = pickerToolBar
        accountBalance.inputAccessoryView = pickerToolBar
        accountNumber.inputAccessoryView = pickerToolBar
        
        
        let margin = view.layoutMarginsGuide
        
        view.addSubview(creditLabel)
        creditLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
        creditLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor).isActive = true
        creditLabel.topAnchor.constraint(equalTo: margin.topAnchor, constant: 10).isActive = true
        creditLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        view.addSubview(brokerText)
        brokerText.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
        brokerText.trailingAnchor.constraint(equalTo: margin.trailingAnchor).isActive = true
        brokerText.topAnchor.constraint(equalTo: creditLabel.bottomAnchor, constant: 10).isActive = true
        brokerText.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        view.addSubview(accountText)
        accountText.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
        accountText.trailingAnchor.constraint(equalTo: margin.trailingAnchor).isActive = true
        accountText.topAnchor.constraint(equalTo: brokerText.bottomAnchor, constant: 10).isActive = true
        accountText.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        view.addSubview(accountBalance)
        accountBalance.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
        accountBalance.trailingAnchor.constraint(equalTo: margin.trailingAnchor).isActive = true
        accountBalance.topAnchor.constraint(equalTo: accountText.bottomAnchor, constant: 10).isActive = true
        accountBalance.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        view.addSubview(accountNumber)
        accountNumber.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
        accountNumber.trailingAnchor.constraint(equalTo: margin.trailingAnchor).isActive = true
        accountNumber.topAnchor.constraint(equalTo: accountBalance.bottomAnchor, constant: 10).isActive = true
        accountNumber.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

}

