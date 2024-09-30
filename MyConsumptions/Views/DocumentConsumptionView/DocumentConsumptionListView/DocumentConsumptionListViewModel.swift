//
//  DocumentConsumptionListViewModel.swift
//  MyConsumptions
//
//  Created by Grigory Sapogov on 30.09.2024.
//

import Foundation
import CoreData
import Combine

final class DocumentConsumptionListViewModel {
    
    var deleteCompletion: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    
    func delete(cdDocument: CDDocumentConsumption) {
        
        Model.coreData.performBackgroundTask { privateContext in
            
            guard let cdDocument = privateContext.objectInContext(CDDocumentConsumption.self, objectID: cdDocument.objectID) else { return }
            
            privateContext.delete(cdDocument)
            
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
