//
//  DocumentIncomeListViewModel.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 28.07.2024.
//

import Foundation
import CoreData
import Combine

final class DocumentIncomeListViewModel {
    
    var deleteCompletion: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    
    func delete(cdDocument: CDDocumentIncome) {
        
        Model.coreData.performBackgroundTask { privateContext in
            
            guard let cdDocument = privateContext.objectInContext(CDDocumentIncome.self, objectID: cdDocument.objectID) else { return }
            
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
