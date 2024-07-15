//
//  CatalogStateIncomeEditViewModel.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 02.04.2024.
//

import CoreData
import Combine

final class CatalogStateIncomeEditViewModel: ObservableObject {
    
    var saveCompletion: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    
    var cdCatalogStateIncome: CDCatalogStateIncome
    
    private let viewContext: NSManagedObjectContext
    
    init(id: NSManagedObjectID? = nil, coreData: ICoreDataStack = Model.coreData) {
        
        self.viewContext = coreData.createContextFromCoordinator(concurrencyType: .mainQueueConcurrencyType)
        
        if let id = id, let cdCatalogStateIncome = self.viewContext.objectInContext(CDCatalogStateIncome.self, objectID: id) {
            self.cdCatalogStateIncome = cdCatalogStateIncome
        }
        else {
            self.cdCatalogStateIncome = CDCatalogStateIncome(context: self.viewContext)
        }
        
    }
    
    func save() {
        
        Model.coreData.save(inContext: self.viewContext) { status in
            
            switch status {
            case .hasNoChanges, .saved:
                self.saveCompletion.send(())
            default:
                break
            }
            
        }
        
        
    }
    
}
