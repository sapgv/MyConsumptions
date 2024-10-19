//
//  DocumentGiveoutDebtListViewModel.swift
//  MyConsumptions
//
//  Created by Grigory Sapogov on 19.10.2024.
//

import Foundation
import CoreData
import Combine

final class DocumentGiveoutDebtListViewModel {
    
    var deleteCompletion: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    
    func delete(cdDocument: CDDocumentGiveoutDebt) {
        
        Model.coreData.performBackgroundTask { privateContext in
            
            guard let cdDocument = privateContext.objectInContext(CDDocumentGiveoutDebt.self, objectID: cdDocument.objectID) else { return }
            
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
