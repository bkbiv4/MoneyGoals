//
//  Import_From_CSV.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 10/14/20.
//

//import Foundation
//import UIKit
//import UniformTypeIdentifiers
//
//class Overview_View_Controller: UIViewController {
//    var transactions = [Transaction]()
//    var csvFile: [[String]]?
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        
//        setupNavigationStyle()
//        
//        let image = UIImage(systemName: "square.and.arrow.up")
//        image?.withTintColor(UIColor.darkBlue)
//
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(scaleSelected))
//    }
//    
//    
//    
//    @objc func scaleSelected() {
//
//        let fileType: [UTType] = [UTType.commaSeparatedText]  /// - Note: This restricts the imported file types to Common Seperated Values
//        let csvPicker = UIDocumentPickerViewController(forOpeningContentTypes: fileType, asCopy: true) /// - Note: This allows the user to select the csv from ther files app
//        csvPicker.delegate = self
//        csvPicker.allowsMultipleSelection = false
//
//        let navcontoller = CustomNavigationController(rootViewController: csvPicker)
//        navcontoller.modalPresentationStyle = .fullScreen
//        present(navcontoller, animated: true, completion: nil)
//    }
//}
//
//
//
//
//extension Overview_View_Controller: UIDocumentPickerDelegate {
//    
//    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//        
//        guard let myURL = urls.first else {
//           return
//        }
////        print("import result : \(myURL)")
//        let data = handleCSVFile(url: myURL)
//        csvFile = data
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM/dd/yyyy"
//        
//        var transaction: Transaction?
//        
//        for columns in csvFile! {
//            if columns.count == 4 {
//                if columns == ["Date", "Description", "Amount", "Running Bal."]{
//                    transaction = nil
//                }
//                else {
//                    let transactionDate = columns[0]
//                    let transactionDescription = columns[1]
//                    let transactionAmount = Double(columns[2]) ?? 0.0
//                    print(columns)
//                    transaction = Transaction(transactionDate: dateFormatter.date(from: transactionDate)!, transactionDescription: transactionDescription, transactionAmount: transactionAmount)
//        //            transactions.append(transaction)
//                    print(transaction)
//                }
//            }
//        }
//    }
//    
//    func handleCSVFile(url: URL) -> [[String]] {
//        if let data = try? String(contentsOf: url) {
//            var result: [[String]] = []
//            let rows = data.components(separatedBy: "\r\n")
//            for row in rows {
//                let columns = row.components(separatedBy: ",")
//                var cells: [String] = []
//                
//                for item in columns {
//                    let cell = item.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range:nil)
//                    if cell != "" {
//                        cells.append(cell)
//                    }
//                }
//                
//                // Only append the array if it's not empty
//                if cells != [] {
//                    result.append(cells)
////                    print(cells)
//                }
//            }
//            
//            // Double check that the array doesn't contain any empty entries
//            for i in 0 ..< result.count {
//                if result[i] == [] {
//                    result.remove(at: i)
//                }
//            }
//            
////            print(result.last!)
//            return result
//        } else {
//            return [[]]
//        }
//    }
//
//}
