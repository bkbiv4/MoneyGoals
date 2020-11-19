//
//  UITextField_Extensions.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 10/17/20.
//

import UIKit

class CurrencyField: UITextField {
    static let max_digits = 15
    static var locale:Locale!
    
    var value:Float {
        get{
            CurrencyFormatter.currency.locale = Locale.current
            let divider:Double = pow(Double(10), Double(CurrencyFormatter.currency.maximumFractionDigits))
            
            if let t = text{
                return Float(t.numbers.integer) / Float(divider)
            }else{
                return 0.0
            }
        }
        set(newVal){
            CurrencyFormatter.currency.locale = Locale.current
            text = CurrencyFormatter.currency.string(from: NSNumber(value: newVal))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        keyboardType = .numbersAndPunctuation
        textAlignment = .right
        editingChanged()
    }
    
    @objc func editingChanged() {
        let max = String(string.numbers.prefix(CurrencyField.max_digits))
        
        CurrencyFormatter.currency.locale = Locale.current
        let divider:Double = pow(Double(10), Double(CurrencyFormatter.currency.maximumFractionDigits))
        text = CurrencyFormatter.currency.string(from: (Double(max.numbers.integer) / divider) as NSNumber)
        self.value = (Float(max.numbers.integer) / Float(divider))
    }
}

