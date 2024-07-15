//
//  Coordinator.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 02.04.2024.
//

import SwiftUI
import CoreData

final class Coordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    
    
}

extension Coordinator {
    
    enum MainView {
        case catalogStateIncome
        case catalogStateConsumption
        case catalogContact
        case catalogDebt
        case catalogWallet
    }
    
    enum CatalogStateIncomeListView: Hashable {
        case new
        case edit(objectID: NSManagedObjectID)
    }
    
    enum CatalogCommonListView: Hashable {
        case new
        case edit(objectID: NSManagedObjectID)
    }
    
}
