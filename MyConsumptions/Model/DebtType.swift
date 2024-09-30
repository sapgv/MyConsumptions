//
//  DebtType.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 19.07.2024.
//

import Foundation

enum DebtType: String, CaseIterable {
    
    case selfDebtCount = "selfDebtCount"
    case giveoutDebt = "giveoutDebt"
    case takeDebt = "takeDebt"
    
    var title: String {
        switch self {
        case .selfDebtCount:
            return "Взаимный расчет"
        case .giveoutDebt:
            return "Нам должны"
        case .takeDebt:
            return "Мы должны"
        }
    }
    
}
