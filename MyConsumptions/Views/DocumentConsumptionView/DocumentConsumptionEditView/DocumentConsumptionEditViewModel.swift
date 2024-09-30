//
//  DocumentConsumptionEditViewModel.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 30.09.2024.
//

import CoreData
import Combine

final class DocumentConsumptionEditViewModel: ObservableObject {
    
    var saveCompletion: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    
    var cdDocumentConsumption: CDDocumentConsumption
    
    private let viewContext: NSManagedObjectContext
    
    private var anyCancellable: AnyCancellable? = nil
    
    init(id: NSManagedObjectID? = nil, coreData: ICoreDataStack = Model.coreData) {
        
        self.viewContext = coreData.createContextFromCoordinator(concurrencyType: .mainQueueConcurrencyType)
        
        if let id = id, let cdDocumentConsumption = self.viewContext.objectInContext(CDDocumentConsumption.self, objectID: id) {
            self.cdDocumentConsumption = cdDocumentConsumption
        }
        else {
            self.cdDocumentConsumption = CDDocumentConsumption(context: self.viewContext)
            self.cdDocumentConsumption.date = .now
        }
        
        self.anyCancellable = self.cdDocumentConsumption.objectWillChange.sink { [weak self] _ in
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
    
    func updateWallet(cdWallet: CDCatalogWallet) {
        let cdWallet = self.viewContext.objectInContext(CDCatalogWallet.self, objectID: cdWallet.objectID)
        self.cdDocumentConsumption.cdCatalogWallet = cdWallet
    }
    
    func createChildContext() -> NSManagedObjectContext {
        let viewContext = Model.coreData.createChildContext(from: self.viewContext, concurrencyType: .mainQueueConcurrencyType)
        return viewContext
    }
    
    func addState(cdDocumentConsumptionState: CDDocumentConsumptionState) {
        guard let context = self.cdDocumentConsumption.managedObjectContext else { return }
        guard let cdDocumentConsumptionState = context.objectInContext(CDDocumentConsumptionState.self, objectID: cdDocumentConsumptionState.objectID) else { return }
        self.cdDocumentConsumption.cdDocumentConsumptionStates.append(cdDocumentConsumptionState)
    }
    
    func refresh() {
        self.viewContext.refreshAllObjects()
    }
    
    func deleteState(cdDocumentConsumptionState: CDDocumentConsumptionState) {
        self.cdDocumentConsumption.cdDocumentConsumptionStates.removeAll(where: { $0.objectID == cdDocumentConsumptionState.objectID })
    }
    
}
