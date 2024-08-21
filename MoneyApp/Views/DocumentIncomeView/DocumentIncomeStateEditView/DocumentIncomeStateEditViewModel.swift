//
//  DocumentIncomeStateEditViewModel.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 28.07.2024.
//

import CoreData
import Combine

final class DocumentIncomeStateEditViewModel: ObservableObject {
    
    var saveCompletion: PassthroughSubject<CDDocumentIncomeState, Never> = PassthroughSubject<CDDocumentIncomeState, Never>()
    
    var cdDocumentIncomeState: CDDocumentIncomeState
    
    var selectStateOnApper: Bool {
        self.cdDocumentIncomeState.cdIncomeState == nil
    }
    
    private let viewContext: NSManagedObjectContext
    
    private var anyCancellable: AnyCancellable? = nil
    
    init(id: NSManagedObjectID? = nil, viewContext: NSManagedObjectContext) {
        
        self.viewContext = viewContext
        
        if let id = id, let cdDocumentIncomeState = self.viewContext.objectInContext(CDDocumentIncomeState.self, objectID: id) {
            self.cdDocumentIncomeState = cdDocumentIncomeState
        }
        else {
            self.cdDocumentIncomeState = CDDocumentIncomeState(context: self.viewContext)
        }
        
        self.anyCancellable = self.cdDocumentIncomeState.objectWillChange.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
        
    }
    
    func save() {
        
        Model.coreData.save(inContext: self.viewContext) { status in
            
            switch status {
            case .hasNoChanges, .saved:
                self.saveCompletion.send(self.cdDocumentIncomeState)
            default:
                break
            }
            
        }
        
    }
    
    func updateState(cdStateIncome: CDCatalogStateIncome) {
        let cdStateIncome = self.viewContext.objectInContext(CDCatalogStateIncome.self, objectID: cdStateIncome.objectID)
        self.cdDocumentIncomeState.cdIncomeState = cdStateIncome
    }
    
}
