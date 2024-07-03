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
    }
    
    enum CatalogStateIncomeListView: Hashable {
        case new
        case cdCatalogStateIncome(objectID: NSManagedObjectID)
    }
    
}