//
//  CatalogCommonEditViewModel.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 15.07.2024.
//

import CoreData
import Combine

final class CatalogCommonEditViewModel<T: NSManagedObject>: ObservableObject {
    
    var saveCompletion: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    
    var cdCatalog: T
    
    private let viewContext: NSManagedObjectContext
    
    init(id: NSManagedObjectID? = nil, coreData: ICoreDataStack = Model.coreData) {
        
        self.viewContext = coreData.createContextFromCoordinator(concurrencyType: .mainQueueConcurrencyType)
        
        if let id = id, let cdCatalog = self.viewContext.objectInContext(T.self, objectID: id) {
            self.cdCatalog = cdCatalog
        }
        else {
            self.cdCatalog = T(context: self.viewContext)
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
