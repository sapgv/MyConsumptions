//
//  DocumentIncomeEditViewModel.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 28.07.2024.
//

import CoreData
import Combine

final class DocumentIncomeEditViewModel: ObservableObject {
    
    var saveCompletion: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    
    var cdDocumentIncome: CDDocumentIncome
    
    private let viewContext: NSManagedObjectContext
    
    private var anyCancellable: AnyCancellable? = nil
    
    init(id: NSManagedObjectID? = nil, coreData: ICoreDataStack = Model.coreData) {
        
        self.viewContext = coreData.createContextFromCoordinator(concurrencyType: .mainQueueConcurrencyType)
        
        if let id = id, let cdDocumentIncome = self.viewContext.objectInContext(CDDocumentIncome.self, objectID: id) {
            self.cdDocumentIncome = cdDocumentIncome
        }
        else {
            self.cdDocumentIncome = CDDocumentIncome(context: self.viewContext)
            self.cdDocumentIncome.date = .now
        }
        
        self.anyCancellable = self.cdDocumentIncome.objectWillChange.sink { [weak self] _ in
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
    
//    func updateContact(cdContact: CDCatalogContact) {
//        let cdContact = self.viewContext.objectInContext(CDCatalogContact.self, objectID: cdContact.objectID)
//        self.cdCatalogDebt.cdContact = cdContact
//    }
    
}
