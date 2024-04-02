//
//  ObjectType.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 02.04.2024.
//

import Foundation

enum ObjectType: String {
    
    case catalogStateIncome
    
    var title: String {
        switch self {
        case .catalogStateIncome:
            return "Статьи дохода"
        }
    }
    
    
    
}
