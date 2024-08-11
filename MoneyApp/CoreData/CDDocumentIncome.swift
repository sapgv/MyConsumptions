//
//  CDDocumentIncome.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 28.07.2024.
//

import Foundation

extension CDDocumentIncome {
    
    var value: Decimal {
        self.cdDocumentIncomeStates.reduce(0, { $0 + ($1.value?.decimalValue ?? 0) })
    }
    
    var cdDocumentIncomeStates: [CDDocumentIncomeState] {
        get {
            self.cdDocumentIncomeStates_?.array as? [CDDocumentIncomeState] ?? []
        }
        set {
            self.cdDocumentIncomeStates_ = NSOrderedSet(array: newValue)
        }
        
    }
    
}
