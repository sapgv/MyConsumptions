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
    
    func updateWallet(cdWallet: CDCatalogWallet) {
        let cdWallet = self.viewContext.objectInContext(CDCatalogWallet.self, objectID: cdWallet.objectID)
        self.cdDocumentIncome.cdCatalogWallet = cdWallet
    }
    
    func createChildContext() -> NSManagedObjectContext {
        let viewContext = Model.coreData.createChildContext(from: self.viewContext, concurrencyType: .mainQueueConcurrencyType)
        return viewContext
    }
    
    func addState(cdDocumentIncomeState: CDDocumentIncomeState) {
        guard let context = self.cdDocumentIncome.managedObjectContext else { return }
        guard let cdDocumentIncomeState = context.objectInContext(CDDocumentIncomeState.self, objectID: cdDocumentIncomeState.objectID) else { return }
        self.cdDocumentIncome.cdDocumentIncomeStates.append(cdDocumentIncomeState)
    }
    
    func refresh() {
        self.viewContext.refreshAllObjects()
    }
    
    func deleteState(cdDocumentIncomeState: CDDocumentIncomeState) {
        self.cdDocumentIncome.cdDocumentIncomeStates.removeAll(where: { $0.objectID == cdDocumentIncomeState.objectID })
    }
    
}
