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
        case documentGiveoutDebt
        case documentReturnGiveoutDebt
        case documentTakenDebt
        case documentReturnTakenDebt
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
    
    enum DocumentGiveoutDebtListView: Hashable {
        case new
        case edit(objectID: NSManagedObjectID)
    }
    
    enum DocumentGiveoutDebtEditView: Hashable {
        case selectContact
        case selectDebt
    }
    
    enum DocumentReturnGiveoutDebtListView: Hashable {
        case new
        case edit(objectID: NSManagedObjectID)
    }
    
    enum DocumentReturnGiveoutDebtEditView: Hashable {
        case selectContact
        case selectDebt
    }
    
    enum DocumentTakenDebtListView: Hashable {
        case new
        case edit(objectID: NSManagedObjectID)
    }
    
    enum DocumentTakenDebtEditView: Hashable {
        case selectContact
        case selectDebt
    }
    
    enum DocumentReturnTakenDebtListView: Hashable {
        case new
        case edit(objectID: NSManagedObjectID)
    }
    
    enum DocumentReturnTakenDebtEditView: Hashable {
        case selectContact
        case selectDebt
    }
    
}
