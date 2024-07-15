//
//  ObjectType.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 02.04.2024.
//

import Foundation

enum ObjectType: String {
    
    case catalogStateIncome
    case catalogStateConsumption
    case catalogContact
    case catalogDebt
    case catalogWallet
    
    var listTitle: String {
        switch self {
        case .catalogStateIncome:
            return "Статьи дохода"
        case .catalogStateConsumption:
            return "Статьи расхода"
        case .catalogContact:
            return "Контакты"
        case .catalogDebt:
            return "Долги"
        case .catalogWallet:
            return "Кошельки"
        }
    }
    
    var editTitle: String {
        switch self {
        case .catalogStateIncome:
            return "Статья дохода"
        case .catalogStateConsumption:
            return "Статья расхода"
        case .catalogContact:
            return "Контакт"
        case .catalogDebt:
            return "Долг"
        case .catalogWallet:
            return "Кошелек"
        }
    }
    
}
