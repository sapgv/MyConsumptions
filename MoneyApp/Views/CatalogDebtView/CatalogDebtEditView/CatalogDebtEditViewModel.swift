//
//  CatalogDebtEditViewModel.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 19.07.2024.
//

import CoreData
import Combine

final class CatalogDebtEditViewModel: ObservableObject {
    
    var saveCompletion: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    
    var cdCatalogDebt: CDCatalogDebt
    
    private let viewContext: NSManagedObjectContext
    
    init(id: NSManagedObjectID? = nil, coreData: ICoreDataStack = Model.coreData) {
        
        self.viewContext = coreData.createContextFromCoordinator(concurrencyType: .mainQueueConcurrencyType)
        
        if let id = id, let cdCatalogDebt = self.viewContext.objectInContext(CDCatalogDebt.self, objectID: id) {
            self.cdCatalogDebt = cdCatalogDebt
        }
        else {
            self.cdCatalogDebt = CDCatalogDebt(context: self.viewContext)
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
    
    func updateContact(cdContact: CDCatalogContact) {
        let cdContact = self.viewContext.objectInContext(CDCatalogContact.self, objectID: cdContact.objectID)
        self.cdCatalogDebt.cdContact = cdContact
    }
    
}
