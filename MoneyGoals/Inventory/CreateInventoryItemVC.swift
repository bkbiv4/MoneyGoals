//
//  Create_InventoryItem_View_Controller.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 10/17/20.
//

import UIKit
import CoreData

class CreateInventoryItemVC: UIViewController {
    
    var itemName : UILabel!
    var itemNameField : UITextField!
    var nameDivider : UIView!
    var itemAmount : UILabel!
    var itemAmountField : UITextField!
    var amountDivider : UIView!
    var itemCost : UILabel!
    var itemCostField : CurrencyField!
    var costDivider : UIView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkBlue
        // Do any additional setup after loading the view.
        self.title = "ADD ITEM"
        setupNavigationStyle()
        setUI()
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .done, target: self, action: #selector(handleSave))
    }
    
    @objc func handleSave(){
        createAccount()
    }
    
    func createAccount() {
        guard let itemName = itemNameField.text else {return}
        let itemAmount = convertStringToDouble(input: itemAmountField.text!)
        let itemCost = convertStringToCurrency(input: itemCostField.text!)!

        let tuple = CoreDataManager.shared.createInventoryItem(itemName: itemName, itemAmount: itemAmount, itemCost: itemCost, itemValue: (itemCost/itemAmount))

        if let error = tuple.1 {
            print(error)
        }

        else {
            // creation success
            dismiss(animated: true, completion: {
                // we'll call the delegate somehow
                print(tuple.0!)
//                self.delegate?.createAccount(account: tuple.0!)
            })
        }
    }
    
    func setUI() {
        let margin = view.layoutMarginsGuide
        
        self.itemName = createLabel(string: "Name of Item:", font: UIFont.font16, color: .white, alignment: .left)
        self.itemNameField = createTextField(placeholder: "Item Name ?", font: UIFont.font16, alignment: .left, color: .white)
        self.nameDivider = createDivider(color: .white)
        
        view.addSubview(itemName)
        setMarginC(subView: itemName, superView: view, margin: margin, heightC: 30, C: 8, top: true)
        view.addSubview(itemNameField)
        setMarginC(subView: itemNameField, superView: itemName, margin: margin, heightC: 30, C: 0, top: false)
        view.addSubview(nameDivider)
        setMarginC(subView: nameDivider, superView: itemNameField, margin: margin, heightC: 1, C: 0, top: false)
        
        self.itemAmount = createLabel(string: "# of Items:", font: UIFont.font16, color: .white, alignment: .left)
        self.itemAmountField = createTextField(placeholder: "# ?", font: UIFont.font16, alignment: .left, color: .white)
//        itemAmountField.delegate = self
        self.amountDivider = createDivider(color: .white)
        
        view.addSubview(itemAmount)
        setMarginC(subView: itemAmount, superView: nameDivider, margin: margin, heightC: 30, C: 8, top: true)
        view.addSubview(itemAmountField)
        setMarginC(subView: itemAmountField, superView: itemAmount, margin: margin, heightC: 30, C: 0, top: false)
        view.addSubview(amountDivider)
        setMarginC(subView: amountDivider, superView: itemAmountField, margin: margin, heightC: 1, C: 0, top: false)
        
        self.itemCost = createLabel(string: "Total Cost of Items:", font: UIFont.font16, color: .white, alignment: .left)
        self.itemCostField = createCurrencyField(placeholder: "0.00", font: UIFont.font16, alignment: .left)
        self.costDivider = createDivider(color: .white)
        
        view.addSubview(itemCost)
        setMarginC(subView: itemCost, superView: (amountDivider), margin: margin, heightC: 30, C: 8, top: true)
        view.addSubview(itemCostField)
        setMarginC(subView: itemCostField, superView: itemCost, margin: margin, heightC: 30, C: 0, top: false)
        view.addSubview(costDivider)
        setMarginC(subView: costDivider, superView: itemCostField, margin: margin, heightC: 1, C: 0, top: false)

    }
}

extension CreateInventoryItemVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
      {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
      }
    
}

