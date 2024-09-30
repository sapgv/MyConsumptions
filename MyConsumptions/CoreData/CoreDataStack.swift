//
//  CoreDataStack.swift
//  WalletTestApp
//
//  Created by Grigory Sapogov on 31.03.2024.
//

import CoreData

public protocol ICoreDataStack: AnyObject {
    
    var modelName: String { get }
    
    var storeType: StoreType { get }
    
    var viewContext: NSManagedObjectContext { get }
    
    var privateContext: NSManagedObjectContext { get }
    
    var persistentContainer: NSPersistentContainer { get }
    
    //MARK: - TASK
    
    func performBackgroundTask(_ block: @escaping (_ privateContext: NSManagedObjectContext) -> Void)
    
    //MARK: - Context
    
    func createChildContext(from context: NSManagedObjectContext, concurrencyType: NSManagedObjectContextConcurrencyType) -> NSManagedObjectContext
    
    func createContextFromCoordinator(concurrencyType: NSManagedObjectContextConcurrencyType) -> NSManagedObjectContext
    
    //MARK: - Save
    
    func save(inContext context: NSManagedObjectContext, completion: ((SaveStatus) -> Void)?)
    
    //MARK: - Fetch
    
    func find<T: NSManagedObject>(_ type: T.Type, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, inContext context: NSManagedObjectContext) -> [T]?
    
    func findOne<T: NSManagedObject>(_ type: T.Type, predicate: NSPredicate?, inContext context: NSManagedObjectContext) -> T?
    
}

open class CoreDataStack: ICoreDataStack {
    
    open var modelName: String
    
    open var storeType: StoreType
    
    open var viewContext: NSManagedObjectContext
    
    open var privateContext: NSManagedObjectContext
    
    open var persistentContainer: NSPersistentContainer
    
    public init(modelName: String,
                inBundle bundle: Bundle = Bundle.main,
                storeType: StoreType = .sql) {
        
        self.modelName = modelName
        
        self.storeType = storeType
        
        let modelURL = bundle.url(forResource: modelName, withExtension: "momd")!

        let model = NSManagedObjectModel(contentsOf: modelURL)!
        
        let container = NSPersistentContainer(name: modelName, managedObjectModel: model)
        
        let storeDirectory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last!
        
        let storeUrl: URL
        switch storeType {
        case .sql:
            storeUrl = storeDirectory.appendingPathComponent("\(modelName).sqlite")
        case .inMemory:
            storeUrl = URL(fileURLWithPath: "/dev/null")
        }
        
        let storeDescription = NSPersistentStoreDescription(url: storeUrl)
        storeDescription.type = storeType.rawValue
        
        container.persistentStoreDescriptions = [storeDescription]
        
        container.loadPersistentStores { persisterStoreDescription, error in
            guard error == nil else {
                Log.shared.log("CoreData Unresolved error \(error!)")
                return
            }
            Log.shared.log("CoreData Initiated \(persisterStoreDescription)")
        }
        
        self.persistentContainer = container
        
        self.viewContext = container.viewContext
        self.viewContext.automaticallyMergesChangesFromParent = true
        
        self.privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        self.privateContext.persistentStoreCoordinator = container.persistentStoreCoordinator
        self.privateContext.automaticallyMergesChangesFromParent = true
        
    }
    
    //MARK: - TASK
    
    open func performBackgroundTask(_ block: @escaping (_ privateContext: NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask { context in
            block(context)
        }
    }
    
    //MARK: - Context
    
    open func createChildContext(from context: NSManagedObjectContext, concurrencyType: NSManagedObjectContextConcurrencyType) -> NSManagedObjectContext {
        let newContext = NSManagedObjectContext(concurrencyType: concurrencyType)
        newContext.automaticallyMergesChangesFromParent = true
        newContext.parent = context
        return newContext
    }
    
    open func createContextFromCoordinator(concurrencyType: NSManagedObjectContextConcurrencyType) -> NSManagedObjectContext {
        let newContext = NSManagedObjectContext(concurrencyType: concurrencyType)
        newContext.automaticallyMergesChangesFromParent = true
        newContext.persistentStoreCoordinator = self.persistentContainer.persistentStoreCoordinator
        return newContext
    }
    
    //MARK: - Save
    
    open func save(inContext context: NSManagedObjectContext, completion: ((SaveStatus) -> Void)? = nil) {
        
        guard context.hasChanges else {
            completion?(.hasNoChanges)
            return
        }
        
        do {
            try context.save()
            completion?(.saved)
        }
        catch let error {
            Log.shared.log(error.localizedDescription)
            completion?(.error)
            return
        }
        
    }
    
    //MARK: - Fetch
    
    open func find<T: NSManagedObject>(_ type: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, inContext context: NSManagedObjectContext) -> [T]? {
        
        do {
            let request = NSFetchRequest<T>(entityName: type.entityName)
            request.predicate = predicate
            request.sortDescriptors = sortDescriptors
            let result = try context.fetch(request)
            return result
        }
        catch let error {
            Log.shared.log("Could not fetch \(error.localizedDescription)")
            return nil
        }
        
    }
    
    open func findOne<T: NSManagedObject>(_ type: T.Type, predicate: NSPredicate? = nil, inContext context: NSManagedObjectContext) -> T? {
        
        do {
            let request = NSFetchRequest<T>(entityName: type.entityName)
            request.predicate = predicate
            let result = try context.fetch(request)
            return result.first
        }
        catch let error {
            Log.shared.log("Could not fetch \(error.localizedDescription)")
            return nil
        }
        
    }
    
}

