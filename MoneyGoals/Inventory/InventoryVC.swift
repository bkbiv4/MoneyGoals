//
//  Inventory_View_Controller.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 10/17/20.
//

import UIKit
import CoreData

class InventoryVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.inventory = CoreDataManager.shared.fetchInventory()

        // Do any additional setup after loading the view.
        self.title = "Inventory"
        view.backgroundColor = .darkBlue
        setupNavigationMenuStyle()
        InventoryVC.menuOpen = false
        
        inventoryTable.delegate = self
        inventoryTable.dataSource = self
        inventoryTable.register(InventoryItemCell.self, forCellReuseIdentifier: "Inventory_Item_Cell")
        
        setUI()
        
        InventoryVC.menuTable = MenuTableVC(InventoryVC.menuView, self)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: InventoryVC.plusImage, style: .plain, target: self, action: #selector(addInventoryItem))
    }
    

    @objc func addInventoryItem() {
        print("Adding new Inventory Item")
        let vc = CreateInventoryItemVC()
        let navController = CustomNavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
    
    // MARK: - Asset Table Section
        var inventoryTable : UITableView = {
            let table = UITableView()
            table.backgroundColor = .darkBlue
            table.translatesAutoresizingMaskIntoConstraints = false
            return table
        }()
       
        var inventory = [Inventory]()
    
        func setUI() {
            view.addSubview(InventoryVC.superView)
            InventoryVC.superView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            InventoryVC.superView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            InventoryVC.superView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            InventoryVC.superView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            
            InventoryVC.superView.addSubview(inventoryTable)
            inventoryTable.leftAnchor.constraint(equalTo: InventoryVC.superView.leftAnchor).isActive = true
            inventoryTable.topAnchor.constraint(equalTo: InventoryVC.superView.topAnchor).isActive = true
            inventoryTable.rightAnchor.constraint(equalTo: InventoryVC.superView.rightAnchor).isActive = true
            inventoryTable.bottomAnchor.constraint(equalTo: InventoryVC.superView.bottomAnchor).isActive = true
        }

}

extension InventoryVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        inventory.count
        print(inventory.count)
        return inventory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Inventory_Item_Cell", for: indexPath) as! InventoryItemCell
        let item = inventory[indexPath.row]
        cell.item = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
