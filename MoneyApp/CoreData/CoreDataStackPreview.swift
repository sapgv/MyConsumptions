//
//  CoreDataStackPreview.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 03.07.2024.
//

import CoreData

extension CoreDataStack {
    
    static var cdCatalogStateIncomePreview: CDCatalogStateIncome! {
        self.cdCatalogStateIncomeArrayPreview.first
    }
    
    static var cdCatalogStateIncomeArrayPreview: [CDCatalogStateIncome] {
        CoreDataStack.previewStack.find(CDCatalogStateIncome.self, predicate: nil, sortDescriptors: nil, inContext: CoreDataStack.previewStack.viewContext) ?? []
    }
    
    static var cdCatalogDebtPreview: CDCatalogDebt! {
        self.cdCatalogDebtArrayPreview.first
    }
    
    static var cdCatalogDebtArrayPreview: [CDCatalogDebt] {
        CoreDataStack.previewStack.find(CDCatalogDebt.self, predicate: nil, sortDescriptors: nil, inContext: CoreDataStack.previewStack.viewContext) ?? []
    }
    
    @discardableResult
    private static func createCDCatalogStateIncome(inContext context: NSManagedObjectContext) -> [CDCatalogStateIncome] {
        
        var array: [CDCatalogStateIncome] = []
        for i in 1...10 {
            let cdCatalogStateIncome = CDCatalogStateIncome(context: context)
            cdCatalogStateIncome.name = "State \(i)"
            array.append(cdCatalogStateIncome)
        }
        
        return array
        
    }
    
    @discardableResult
    private static func createCDCatalogDebt(inContext context: NSManagedObjectContext) -> [CDCatalogDebt] {
        
        var array: [CDCatalogDebt] = []
        for i in 1...10 {
            let cdCatalogStateIncome = CDCatalogDebt(context: context)
            cdCatalogStateIncome.name = "Debt \(i)"
            array.append(cdCatalogStateIncome)
        }
        
        return array
        
    }
    
    static var previewStack: ICoreDataStack = {
        
        let coreDataStack = CoreDataStack(modelName: "Model", storeType: .inMemory)
        
        let viewContext = coreDataStack.viewContext
        
        createCDCatalogStateIncome(inContext: viewContext)
        createCDCatalogDebt(inContext: viewContext)
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return coreDataStack
        
    }()
    
}
