//
//  Decimal + Extensions.swift
//  iMoneyUI
//
//  Created by Grigory Sapogov on 18.02.2024.
//  Copyright © 2024 sapgv. All rights reserved.
//

import Foundation

public extension Decimal {
    
    var string: String {
        guard self > 0 else { return "" }
        return Model.decimalFormatter.string(from: self as NSNumber) ?? ""
    }
    
    var currencyString: String {
        
        let value = NSDecimalNumber(decimal: self)
        return value.currencyString
        
    }
    
    var isClean: Bool {
        let value = Double(truncating: self as NSNumber)
        return value.truncatingRemainder(dividingBy: 1) == 0
    }
    
    var cleanFormatted: String {
        guard self > 0 else { return "" }
        guard self.isClean else {
            return self.string
        }
        return Model.decimalFormatter.string(from: self as NSNumber) ?? ""
    }
    
}

public extension NSDecimalNumber {
    
    var currencyString: String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        let text = formatter.string(from: self) ?? ""
        return text
        
    }
    
}


