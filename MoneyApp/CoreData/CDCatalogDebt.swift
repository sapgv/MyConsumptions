//
//  CDCatalogDebt.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 19.07.2024.
//

import Foundation

extension CDCatalogDebt {
    
    var debtType: DebtType? {
        get {
            guard let value = self.debtType_ else { return nil }
            return DebtType(rawValue: value)
        }
        set {
            self.debtType_ = newValue?.rawValue
        }
    }
    
}

