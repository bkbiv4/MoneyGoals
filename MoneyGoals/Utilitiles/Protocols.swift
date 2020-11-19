//
//  DoubleTextFieldDelegate.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 10/17/20.
//

protocol Create_Inventory_Item_VCD {
    // - Note : This function will handle the creation of Assets
    func createItem(item: Inventory)
    // - Note : This function will handle the editing of Assets
    func editItem(item: Inventory)
}

protocol CreateTransactionVCD {
    func createTransaction(transaction: Transaction)
    func editTransaction(transaction: Transaction)
}


enum MainAccountCategories: String {
    case Assets
    case Investments
    case Credit
    case Loans
    case Other
}
