//
//  CreateBill.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 11/3/20.
//

import UIKit

class CreateBillVC: UIViewController {
    
    var delegate: CreateBillsVCD?
    
    var bill : Bill? {
        didSet {
            billNameTextField.text = bill?.billName
            billValueField.text = convertCurrencyToString(amount: bill!.billValue)

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"

            billDateField.text = dateFormatter.string(from: (bill?.billDate)!)
        }
    }
    
    var billNameLabel: UILabel!
    var billNameTextField : UITextField!
    var billValueLabel : UILabel!
    var billValueField : CurrencyField!
    var billDateField : UITextField!
    
    var saveButton: UIButton = {
        let button = UIButton();
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(target, action: #selector(saveBill), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let billDatePicker : UIDatePicker = { let dp = UIDatePicker(); dp.preferredDatePickerStyle = .wheels ; dp.datePickerMode = .date; dp.translatesAutoresizingMaskIntoConstraints = false; return dp }()
    
    let font = UIFont.font16
    
    override func viewWillLayoutSubviews() {
//        let height = view.bounds.size.height
        let width = view.bounds.size.width
        self.view.frame = CGRect(x: 0, y: 0, width: width, height: 300)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        billNameLabel = createLabel(string: "Name of Bill", font: font, color: .white, alignment: .left)
        billNameTextField = createTextField(placeholder: "---", font: font, alignment: .left, color: .white)
        billValueLabel = createLabel(string: "Bill Amount", font: font, color: .white, alignment: .left)
        billValueField = createCurrencyField(placeholder: "", font: font, alignment: .left)
        setUI()
    }
    
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            if view.frame.origin.y == 0 {
//                self.view.frame.origin.y -= keyboardSize.height
//            }
//        }
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//        if view.frame.origin.y != 0 {
//            self.view.frame.origin.y = 0
//        }
//    }
    
    @objc func saveBill() {
        print("saving")
        
        guard let billName = billNameTextField.text else {
            return
        }
        
        print(billName)
        
        let billValue = convertStringToCurrency(input: billValueField.text!)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let billDate = dateFormatter.date(from: billDateField.text!)!
        
        
        let tuple = CoreDataManager.shared.createBll(billName: billName, billValue: billValue, billDate: billDate)
        
        if let error = tuple.1 {
            print(error)
        }
        else {
            dismiss(animated: true, completion: {
                self.delegate?.createBill(tuple.0!)
            })
        }
        
    }
    
    func setUI() {
        
            
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let datePlaceHolder = dateFormatter.string(from: Date())
        
        billDateField = createTextField(placeholder: datePlaceHolder, font: font, alignment: .left, color: .white)
        
        billDateField.inputView = billDatePicker
         
        let margin = view.layoutMarginsGuide
        
        view.addSubview(saveButton)
        saveButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        saveButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(billNameLabel)
        billNameLabel.topAnchor.constraint(equalTo: saveButton.bottomAnchor).isActive = true
        billNameLabel.leftAnchor.constraint(equalTo: margin.leftAnchor).isActive = true
        billNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        billNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(billNameTextField)
        billNameTextField.topAnchor.constraint(equalTo: billNameLabel.bottomAnchor).isActive = true
        billNameTextField.leftAnchor.constraint(equalTo: margin.leftAnchor).isActive = true
        billNameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        billNameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(billValueLabel)
        billValueLabel.topAnchor.constraint(equalTo: billNameTextField.bottomAnchor, constant: 10).isActive = true
        billValueLabel.leftAnchor.constraint(equalTo: margin.leftAnchor).isActive = true
        billValueLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        billValueLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(billValueField)
        billValueField.topAnchor.constraint(equalTo: billValueLabel.bottomAnchor).isActive = true
        billValueField.leftAnchor.constraint(equalTo: margin.leftAnchor).isActive = true
        billValueField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        billValueField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(billDateField)
        billDateField.topAnchor.constraint(equalTo: billValueField.bottomAnchor, constant: 10).isActive = true
        billDateField.leftAnchor.constraint(equalTo: margin.leftAnchor).isActive = true
        billDateField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        billDateField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
    }
}
