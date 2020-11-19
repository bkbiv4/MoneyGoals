//
//  Overview_View_Controller.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 10/12/20.
//

import Foundation
import UIKit
import UniformTypeIdentifiers

//class Overview_View_Controller: UIViewController {
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        
//        setupNavigationMenuStyle()
//        view.backgroundColor = .darkBlue
//        Overview_View_Controller.menuOpen = false
//        
//        self.title = "Overview"
//        Overview_View_Controller.menuTable = Menu_TableView_Controller(Overview_View_Controller.menuView, self)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Overview_View_Controller.plusImage, style: .plain, target: self, action: #selector(addAccount))
//    }
//    
//    
//    
//    @objc func addAccount() {
//        print("Add an account manually or by linking")
//        let accountCreationOptions = UIAlertController(title: "Add Account", message: "Link your new account or set it up manually", preferredStyle: .actionSheet)
//        
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        
//        /// - Note: Fix this Part
//        let linkAction = UIAlertAction(title: "Link Account", style: .default) { (action) in
//            /// - Note: Set up Plaid Linking
//            print("Linking")
//        }
//            
//        let manualAction = UIAlertAction(title: "Manual", style: .default) { (action) in
////            let createAccount = CreateAccountVC()
////            createAccount.delegate = self
////            let navController = CustomNavigationController(rootViewController: createAccount)
////            navController.modalPresentationStyle = .fullScreen
////            self.present(navController, animated: true, completion: nil)
//        }
//        
//        accountCreationOptions.addAction(cancelAction)
//        accountCreationOptions.addAction(linkAction)
//        accountCreationOptions.addAction(manualAction)
//        
//        accountCreationOptions.pruneNegativeWidthConstraints()
//        
//        self.present(accountCreationOptions, animated: true)
//    }
//    
//    
//}




