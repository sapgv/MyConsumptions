//
//  CDCatalogName.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 15.07.2024.
//

import CoreData

protocol CDCatalogName: NSManagedObject, Identifiable {
    
    var name: String? { get set }
    
}

extension CDCatalogName {
    
    static var sortKey: String {
        "name"
    }
    
}

extension CDCatalogStateIncome: CDCatalogName {
    
}

extension CDCatalogStateConsumption: CDCatalogName {
    
}

extension CDCatalogContact: CDCatalogName {
    
}

extension CDCatalogDebt: CDCatalogName {
    
}

extension CDCatalogWallet: CDCatalogName {
    
}

