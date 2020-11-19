//
//  Core_Data_Manager.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 10/17/20.
//

/// ------------------------------------------------------
/// - Note: This File is used to manage the CoreData Structure of the App
/// ------------------------------------------------------

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()  //This will live forever as long as your application is still alive, it's properties will too
    
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MoneyGoals")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed: \(err)")
            }
        }
        return container
    }() //Creates a Container that functions as a shell for the CoreDataModel
    
    func fetchBills() -> [Bill] {
        let context = persistentContainer.viewContext  //Intializes the context
                
        let fetchRequest = NSFetchRequest<Bill>(entityName: "Bill") //Fetches all CoreData Data Associated with the Entity Named Account
        do {
            let bill = try context.fetch(fetchRequest)
            return bill
        } catch let fetchErr {
            print("Failed to fetch firms:", fetchErr)
            return []
        }
    }
    
    // MARK: - This Section Handles the Fetch Functions of the CoreDataManager
    
    func fetchInventory() -> [Inventory] {
        let context = persistentContainer.viewContext  //Intializes the context
                
        let fetchRequest = NSFetchRequest<Inventory>(entityName: "Inventory") //Fetches all CoreData Data Associated with the Entity Named Account
        do {
            let inventory = try context.fetch(fetchRequest)
            return inventory
        } catch let fetchErr {
            print("Failed to fetch firms:", fetchErr)
            return []
        }
    } //Fetches all of the InventoryItems in the CoreDataManager
    
    func fetchTransaction() -> [Transaction] {
        let context = persistentContainer.viewContext  //Intializes the context
                
        let fetchRequest = NSFetchRequest<Transaction>(entityName: "Transaction") //Fetches all CoreData Data Associated with the Entity Named Account
        do {
            let transactions = try context.fetch(fetchRequest)
            return transactions
        } catch let fetchErr {
            print("Failed to fetch firms:", fetchErr)
            return []
        }
    } //Fetches all of the InventoryItems in the CoreDataManager
    
    func fetchAccounts() -> [Account] {
        let context = persistentContainer.viewContext  //Intializes the context
                
        let fetchRequest = NSFetchRequest<Account>(entityName: "Account") //Fetches all CoreData Data Associated with the Entity Named Account
        do {
            let accounts = try context.fetch(fetchRequest)
            return accounts
        } catch let fetchErr {
            print("Failed to fetch firms:", fetchErr)
            return []
        }
    } //Fetches all of the InventoryItems in the CoreDataManager
    
    // MARK: - This Section Handles the Creation Functions of the CoreDataManager
    
    func createInventoryItem(itemName: String, itemAmount: Double, itemCost: Double, itemValue: Double) -> (Inventory?, Error?) {
        let context = persistentContainer.viewContext //Initializes the Context
        
        let inventory = NSEntityDescription.insertNewObject(forEntityName: "Inventory", into: context) as! Inventory
        
        inventory.setValue(itemName, forKey: "itemName")
        inventory.setValue(itemAmount, forKey: "itemAmount")
        inventory.setValue(itemCost, forKey: "itemCost")
        inventory.setValue(itemValue, forKey: "itemValue")
        
        do {
            try context.save()
            //save succeds
            return (inventory, nil)
        } catch let err {
            print("FAILED TO CREATE NEW ITEM:", err)
            return (nil, err)
        }
    }
    
    func createTransaction(account: Account, transactionDate: Date, transactionType: String, transactionDescription: String, transactionValue: Double, mainCategory: String, subCategory: String) -> (Transaction?, Error?) {
        let context = persistentContainer.viewContext //Initializes the Context
        
        let transaction = NSEntityDescription.insertNewObject(forEntityName: "Transaction", into: context) as! Transaction
        
        transaction.setValue(transactionDate, forKey: "transactionDate")
        transaction.setValue(transactionType, forKey: "transactionType")
        transaction.setValue(transactionDescription, forKey: "transactionDescription")
        transaction.setValue(transactionValue, forKey: "transactionValue")
        
        let category = NSEntityDescription.insertNewObject(forEntityName: "Category", into: context) as! Category
        transaction.category = category
        category.mainCategory = mainCategory
        category.subCategory = subCategory
        
//        let account = NSEntityDescription.insertNewObject(forEntityName: "Account", into: context) as! Account
        transaction.account = account
        
        do {
            try context.save()
            //save succeds
            return (transaction, nil)
        } catch let err {
            print("FAILED TO CREATE NEW ITEM:", err)
            return (nil, err)
        }
    }
    

    
//    func createAccount(accountName: String, accountBroker: Broker, accountType: AccountType, accountBalance: Double, accountNumber: Double) -> (Account?, Error?) {
//        let context = persistentContainer.viewContext //Initializes the Context
//
//        let account = NSEntityDescription.insertNewObject(forEntityName: "Account", into: context) as! Account
//
//        account.setValue(accountName, forKey: "accountName")
//        account.setValue(accountBalance, forKey: "accountBalance")
//        account.setValue(accountNumber, forKey: "accountNumber")
//
//        account.broker = accountBroker
//        account.accountType = accountType
//
//        do {
//            try context.save()
//            //save succeds
//            return (account, nil)
//        } catch let err {
//            print("FAILED TO CREATE NEW ITEM:", err)
//            return (nil, err)
//        }
//    }
    
    func createAccountCredit(accountName: String, accountBroker: String, accountST: String, creditLimit: Double, accountBalance: Double, accountNumber: String) -> (Account?, Error?) {
        let context = persistentContainer.viewContext //Initializes the Context
        
        let account = NSEntityDescription.insertNewObject(forEntityName: "Account", into: context) as! Account
        account.setValue(accountName, forKey: "accountName")
        account.setValue(accountNumber, forKey: "accountNumber")
        account.setValue(accountBalance, forKey: "accountBalance")
        
        let broker = NSEntityDescription.insertNewObject(forEntityName: "Broker", into: context) as! Broker
        account.broker = broker
        broker.brokerName = accountBroker
        
        let credit = NSEntityDescription.insertNewObject(forEntityName: "Credit", into: context) as! Credit
        account.credit = credit
        credit.creditLimit = creditLimit
        
        let accountType = NSEntityDescription.insertNewObject(forEntityName: "AccountType", into: context) as! AccountType
        account.accountType = accountType
        accountType.mainType = "Credit"
        accountType.subType = accountST
        do {
            try context.save()
            //save succeds
            return (account, nil)
        } catch let err {
            print("FAILED TO CREATE NEW ITEM:", err)
            return (nil, err)
        }
    }
    
    func createAccountInvestment(accountName: String, accountBroker: String, accountST: String, accountBalance: Double, accountNumber: String) -> (Account?, Error?) {
        let context = persistentContainer.viewContext //Initializes the Context
        
        let account = NSEntityDescription.insertNewObject(forEntityName: "Account", into: context) as! Account
        account.setValue(accountName, forKey: "accountName")
        account.setValue(accountNumber, forKey: "accountNumber")
        account.setValue(accountBalance, forKey: "accountBalance")
        
        let broker = NSEntityDescription.insertNewObject(forEntityName: "Broker", into: context) as! Broker
        account.broker = broker
        broker.brokerName = accountBroker
        
//        let investment = NSEntityDescription.insertNewObject(forEntityName: "Investment", into: context) as! Investment
//        account.investment = investment
//        investment.investmentBalance = investmentBalance
        
        let accountType = NSEntityDescription.insertNewObject(forEntityName: "AccountType", into: context) as! AccountType
        account.accountType = accountType
        accountType.mainType = "Investments"
        accountType.subType = accountST
        do {
            try context.save()
            //save succeds
            return (account, nil)
        } catch let err {
            print("FAILED TO CREATE NEW ITEM:", err)
            return (nil, err)
        }
    }
    
    func createAccountAsset(accountName: String, accountBroker: String, accountST: String, accountBalance: Double, accountNumber: String) -> (Account?, Error?) {
        let context = persistentContainer.viewContext //Initializes the Context
        
        let account = NSEntityDescription.insertNewObject(forEntityName: "Account", into: context) as! Account
        account.setValue(accountName, forKey: "accountName")
        account.setValue(accountNumber, forKey: "accountNumber")
        account.setValue(accountBalance, forKey: "accountBalance")
        
        
        let broker = NSEntityDescription.insertNewObject(forEntityName: "Broker", into: context) as! Broker
        account.broker = broker
        broker.brokerName = accountBroker
        
//        let asset = NSEntityDescription.insertNewObject(forEntityName: "Asset", into: context) as! Asset
//        account.asset = asset
//        asset.accountBalance = accountBalance
        
        let accountType = NSEntityDescription.insertNewObject(forEntityName: "AccountType", into: context) as! AccountType
        account.accountType = accountType
        accountType.mainType = "Assets"
        accountType.subType = accountST
        do {
            try context.save()
            //save succeds
            return (account, nil)
        } catch let err {
            print("FAILED TO CREATE NEW ITEM:", err)
            return (nil, err)
        }
    }
    
    func createAccountLoan(accountName: String, accountBroker: String, accountST: String, accountBalance: Double, accountNumber: String) -> (Account?, Error?) {
        let context = persistentContainer.viewContext //Initializes the Context
        
        let account = NSEntityDescription.insertNewObject(forEntityName: "Account", into: context) as! Account
        account.setValue(accountName, forKey: "accountName")
        account.setValue(accountNumber, forKey: "accountNumber")
        account.setValue(accountBalance, forKey: "accountBalance")
        
        let broker = NSEntityDescription.insertNewObject(forEntityName: "Broker", into: context) as! Broker
        account.broker = broker
        broker.brokerName = accountBroker
        
//        let loan = NSEntityDescription.insertNewObject(forEntityName: "Loan", into: context) as! Loan
//        account.loan = loan
//        loan.accountBalance = accountBalance
        
        let accountType = NSEntityDescription.insertNewObject(forEntityName: "AccountType", into: context) as! AccountType
        account.accountType = accountType
        accountType.mainType = "Loans"
        accountType.subType = accountST
        do {
            try context.save()
            //save succeds
            return (account, nil)
        } catch let err {
            print("FAILED TO CREATE NEW ITEM:", err)
            return (nil, err)
        }
    }
    
    func createAccountOther(accountName: String, accountBroker: String, accountST: String, accountBalance: Double, accountNumber: String) -> (Account?, Error?) {
        let context = persistentContainer.viewContext //Initializes the Context
        
        let account = NSEntityDescription.insertNewObject(forEntityName: "Account", into: context) as! Account
        account.setValue(accountName, forKey: "accountName")
        account.setValue(accountNumber, forKey: "accountNumber")
        account.setValue(accountBalance, forKey: "accountBalance")
        
        let broker = NSEntityDescription.insertNewObject(forEntityName: "Broker", into: context) as! Broker
        account.broker = broker
        broker.brokerName = accountBroker
        
//        let other = NSEntityDescription.insertNewObject(forEntityName: "Other", into: context) as! Other
//        account.other = other
//        other.accountBalance = accountBalance
        
        let accountType = NSEntityDescription.insertNewObject(forEntityName: "AccountType", into: context) as! AccountType
        account.accountType = accountType
        accountType.mainType = "Investments"
        accountType.subType = accountST
        do {
            try context.save()
            //save succeds
            return (account, nil)
        } catch let err {
            print("FAILED TO CREATE NEW ITEM:", err)
            return (nil, err)
        }
    }
    
    func createBll(billName: String, billValue: Double, billDate: Date) -> (Bill?, Error?) {
        
        let context = persistentContainer.viewContext
        
        let bill = NSEntityDescription.insertNewObject(forEntityName: "Bill", into: context) as! Bill
        bill.setValue(billName, forKey: "billName")
        bill.setValue(billValue, forKey: "billValue")
        bill.setValue(billDate, forKey: "billDate")
        
        
        do {
            try context.save()
            return (bill, nil)
        }
        catch let err {
            print("Failed to create your new Bill", err)
            return (nil, err)
        }
    }
}

