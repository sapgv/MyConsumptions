//
//  CoreDataStackPreview.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 03.07.2024.
//

import CoreData

extension CoreDataStack {
    
    static var cdCatalogStateIncomePreview: CDCatalogStateIncome! {
//        return CoreDataStack.previewStack.findOne(CDCatalogStateIncome.self, predicate: nil, inContext: CoreDataStack.previewStack.viewContext)
        self.cdCatalogStateIncomeArrayPreview.first
    }
    
    static var cdCatalogStateIncomeArrayPreview: [CDCatalogStateIncome] {
        CoreDataStack.previewStack.find(CDCatalogStateIncome.self, predicate: nil, sortDescriptors: nil, inContext: CoreDataStack.previewStack.viewContext) ?? []
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
    
    static var previewStack: ICoreDataStack = {
        
        let coreDataStack = CoreDataStack(modelName: "Model", storeType: .inMemory)
        
        let viewContext = coreDataStack.viewContext
        
        
//        let cdCatalogStateIncome = CDCatalogStateIncome(context: viewContext)
//        cdCatalogStateIncome.name = "State sdfsdf"
        
        createCDCatalogStateIncome(inContext: viewContext)
//        CoreDataStack.cdCatalogStateIncomeArrayPreview = [cdCatalogStateIncome]
        
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
