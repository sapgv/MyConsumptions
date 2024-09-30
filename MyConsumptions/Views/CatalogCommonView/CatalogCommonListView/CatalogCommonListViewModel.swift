//
//  CatalogCommonListViewModel.swift
//  MyConsumptions
//
//  Created by Grigory Sapogov on 30.09.2024.
//

import Foundation
import CoreData
import Combine

final class CatalogCommonListViewModel<T: CDCatalogName> {
    
    var deleteCompletion: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    
    func delete(cdCatalog: T) {
        
        Model.coreData.performBackgroundTask { privateContext in
            
            guard let cdCatalog = privateContext.objectInContext(T.self, objectID: cdCatalog.objectID) else { return }
            
            privateContext.delete(cdCatalog)
            
            Model.coreData.save(inContext: privateContext) { status in
                
                switch status {
                case .hasNoChanges, .saved:
                    self.deleteCompletion.send(())
                default:
                    break
                }
                
            }
            
        }
        
    }
    
}
