//
//  DocumentReturnTakenDebtEditViewModel.swift
//  MyConsumptions
//
//  Created by Grigory Sapogov on 31.10.2024.
//

import CoreData
import Combine

final class DocumentReturnTakenDebtEditViewModel: ObservableObject {
    
    var saveCompletion: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    
    var cdDocument: CDDocumentReturnTakenDebt
    
    private let viewContext: NSManagedObjectContext
    
    private var anyCancellable: AnyCancellable? = nil
    
    init(id: NSManagedObjectID? = nil, coreData: ICoreDataStack = Model.coreData) {
        
        self.viewContext = coreData.createContextFromCoordinator(concurrencyType: .mainQueueConcurrencyType)
        
        if let id = id, let cdDocument = self.viewContext.objectInContext(CDDocumentReturnTakenDebt.self, objectID: id) {
            self.cdDocument = cdDocument
        }
        else {
            self.cdDocument = CDDocumentReturnTakenDebt(context: self.viewContext)
            self.cdDocument.date = .now
        }
        
        self.anyCancellable = self.cdDocument.objectWillChange.sink { [weak self] _ in
            self?.objectWillChange.send()
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
        self.cdDocument.cdContact = cdContact
    }
    
    func updateDebt(cdDebt: CDCatalogDebt) {
        let cdDebt = self.viewContext.objectInContext(CDCatalogDebt.self, objectID: cdDebt.objectID)
        self.cdDocument.cdDebt = cdDebt
    }
    
    func refresh() {
        self.viewContext.refreshAllObjects()
    }
    
}
