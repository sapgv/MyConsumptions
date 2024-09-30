//
//  DocumentConsumptionStateEditViewModel.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 30.09.2024.
//

import CoreData
import Combine

final class DocumentConsumptionStateEditViewModel: ObservableObject {
    
    var saveCompletion: PassthroughSubject<CDDocumentConsumptionState, Never> = PassthroughSubject<CDDocumentConsumptionState, Never>()
    
    var cdDocumentConsumptionState: CDDocumentConsumptionState
    
    var selectStateOnApper: Bool {
        self.cdDocumentConsumptionState.cdConsumptionState == nil
    }
    
    private let viewContext: NSManagedObjectContext
    
    private var anyCancellable: AnyCancellable? = nil
    
    init(id: NSManagedObjectID? = nil, viewContext: NSManagedObjectContext) {
        
        self.viewContext = viewContext
        
        if let id = id, let cdDocumentConsumptionState = self.viewContext.objectInContext(CDDocumentConsumptionState.self, objectID: id) {
            self.cdDocumentConsumptionState = cdDocumentConsumptionState
        }
        else {
            self.cdDocumentConsumptionState = CDDocumentConsumptionState(context: self.viewContext)
        }
        
        self.anyCancellable = self.cdDocumentConsumptionState.objectWillChange.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
        
    }
    
    func save() {
        
        Model.coreData.save(inContext: self.viewContext) { status in
            
            switch status {
            case .hasNoChanges, .saved:
                self.saveCompletion.send(self.cdDocumentConsumptionState)
            default:
                break
            }
            
        }
        
    }
    
    func updateState(cdStateConsumption: CDCatalogStateConsumption) {
        let cdStateConsumption = self.viewContext.objectInContext(CDCatalogStateConsumption.self, objectID: cdStateConsumption.objectID)
        self.cdDocumentConsumptionState.cdConsumptionState = cdStateConsumption
    }
    
}
