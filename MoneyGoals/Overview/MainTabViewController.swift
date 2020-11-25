//
//  MainTabViewController.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 11/24/20.
//

import UIKit

class MainTabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let viewFrame = view.frame
//        menuContainer.frame = CGRect(x: 0.0, y: 0.0, width: round(viewFrame.width * 0.45), height: viewFrame.height)
        
        self.tabBarController?.tabBar.tintColor = .orange
        self.tabBarController?.tabBar.barTintColor = .green
        
        setupNavigationStyle()
        navigationController?.navigationBar.prefersLargeTitles = false
//        view.backgroundColor = .springgreen
        var accountTVCNC :      UINavigationController!
        var transactionsTVCNC : UINavigationController!
        var billTVCNC :         UINavigationController!
        var paycheckTVCNC :     UINavigationController!
        var paycheckVCNC :      UINavigationController!
        var overviewVCNC :      UINavigationController!
        var stockVCNC :         UINavigationController!
        
        accountTVCNC = UINavigationController.init(rootViewController: AccountsVC())
        accountTVCNC.tabBarItem = UITabBarItem(title: "Accounts", image: UIImage(named: "add"), tag: 0)
        
        transactionsTVCNC = UINavigationController.init(rootViewController: TransactionsVC())
        transactionsTVCNC.tabBarItem = UITabBarItem(title: "Transactions", image:  UIImage(named: "add"), tag: 1)
        
        billTVCNC = UINavigationController.init(rootViewController: BillsVC())
        billTVCNC.tabBarItem = UITabBarItem(title: "Bills", image: UIImage(named: "add"), tag: 2)
        
//        paycheckTVCNC = UINavigationController.init(rootViewController: PaycheckTVC())
//        paycheckTVCNC.tabBarItem = UITabBarItem(title: "Paychecks", image: UIImage(named: "add"), tag: 3)
        
//        paycheckVCNC = UINavigationController.init(rootViewController: PaycheckOverviewVC())
//        paycheckVCNC.tabBarItem = UITabBarItem(title: "Paycheck Overview", image: UIImage(named: "add"), tag: 4)
        
//        overviewVCNC = UINavigationController.init(rootViewController: OverviewVC())
//        overviewVCNC.tabBarItem = UITabBarItem(title: "Overview", image: UIImage(named: "add"), tag: 5)
        
//        stockVCNC = UINavigationController.init(rootViewController: StockTVC())
//        stockVCNC.tabBarItem = UITabBarItem(title: "Stocks", image: UIImage(named: "add"), tag: 6)

//        let tabBarList = [transactionsTVCNC, accountTVCNC, billTVCNC]
        
        let tabBarList = [accountTVCNC]

        viewControllers = tabBarList as? [UIViewController]
        
        self.selectedIndex = 1
        
        modalPresentationStyle = .fullScreen

    }
    
}
