//
//  DocumentTransferEditViewModel.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 30.09.2024.
//

import CoreData
import Combine

final class DocumentTransferEditViewModel: ObservableObject {
    
    var saveCompletion: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    
    var cdDocumentTransfer: CDDocumentTransfer
    
    private let viewContext: NSManagedObjectContext
    
    private var anyCancellable: AnyCancellable? = nil
    
    init(id: NSManagedObjectID? = nil, coreData: ICoreDataStack = Model.coreData) {
        
        self.viewContext = coreData.createContextFromCoordinator(concurrencyType: .mainQueueConcurrencyType)
        
        if let id = id, let cdDocumentTransfer = self.viewContext.objectInContext(CDDocumentTransfer.self, objectID: id) {
            self.cdDocumentTransfer = cdDocumentTransfer
        }
        else {
            self.cdDocumentTransfer = CDDocumentTransfer(context: self.viewContext)
            self.cdDocumentTransfer.date = .now
        }
        
        self.anyCancellable = self.cdDocumentTransfer.objectWillChange.sink { [weak self] _ in
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
    
    func updateWalletFrom(cdWallet: CDCatalogWallet) {
        let cdWallet = self.viewContext.objectInContext(CDCatalogWallet.self, objectID: cdWallet.objectID)
        self.cdDocumentTransfer.cdCatalogWalletFrom = cdWallet
    }
    
    func updateWalletTo(cdWallet: CDCatalogWallet) {
        let cdWallet = self.viewContext.objectInContext(CDCatalogWallet.self, objectID: cdWallet.objectID)
        self.cdDocumentTransfer.cdCatalogWalletTo = cdWallet
    }
    
    func refresh() {
        self.viewContext.refreshAllObjects()
    }
    
}
