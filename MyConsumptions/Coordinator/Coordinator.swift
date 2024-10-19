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
        case documentIncome
        case documentConsumption
        case documentTransfer
        case documentGiveDebt
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
    
    enum CatalogCommonSelectListView: Hashable {
        case new
    }
    
    enum CatalogDebtEditView: Hashable {
        case selectContact
    }
    
    enum DocumentIncomeListView: Hashable {
        case new
        case edit(objectID: NSManagedObjectID)
    }
    
    enum DocumentIncomeEditView: Hashable {
        case selectWallet
        case selectIncomeState(objectId: NSManagedObjectID)
    }
    
    enum DocumentIncomeStateEditView: Hashable {
        case selectStateIncome
    }
    
    enum DocumentConsumptionListView: Hashable {
        case new
        case edit(objectID: NSManagedObjectID)
    }
    
    enum DocumentConsumptionStateEditView: Hashable {
        case selectStateConsumption
    }
    
    enum DocumentConsumptionEditView: Hashable {
        case selectWallet
        case selectConsumptionState(objectId: NSManagedObjectID)
    }
    
    enum DocumentTransferListView: Hashable {
        case new
        case edit(objectID: NSManagedObjectID)
    }
    
    enum DocumentTransferEditView: Hashable {
        case selectWalletFrom
        case selectWalletTo
    }
    
    enum DocumentGiveDebtListView: Hashable {
        case new
        case edit(objectID: NSManagedObjectID)
    }
    
    enum DocumentGiveDebtEditView: Hashable {
        case selectContact
        case selectDebt
    }
    
}
