//
//  CDDocumentConsumption.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 30.09.2024.
//

import Foundation

extension CDDocumentConsumption {
    
    var value: Decimal {
        self.cdDocumentConsumptionStates.reduce(0, { $0 + ($1.value?.decimalValue ?? 0) })
    }
    
    var stateComment: String? {
        self.cdDocumentConsumptionStates.compactMap { $0.cdConsumptionState?.name }.joined(separator: ", ")
    }
    
    var cdDocumentConsumptionStates: [CDDocumentConsumptionState] {
        get {
            self.cdDocumentConsumptionStates_?.array as? [CDDocumentConsumptionState] ?? []
        }
        set {
            self.cdDocumentConsumptionStates_ = NSOrderedSet(array: newValue)
        }
    }
    
}
