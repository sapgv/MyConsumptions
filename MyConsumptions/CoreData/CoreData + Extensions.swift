//
//  CoreData + Extensions.swift
//  WalletTestApp
//
//  Created by Grigory Sapogov on 31.03.2024.
//

import CoreData

public extension NSManagedObject {
    
    static var entityName: String {
        return String(describing: self)
    }
    
}

public extension NSManagedObjectContext {
    
    func objectInContext<T: NSManagedObject>(_ type: T.Type, objectID: NSManagedObjectID?) -> T? {
        guard let objectID = objectID else { return nil }
        return self.object(with: objectID) as? T
    }
    
    func existingObject<T: NSManagedObject>(_ type: T.Type, objectID: NSManagedObjectID?) -> T? {
        guard let objectID = objectID else { return nil }
        guard let object = try? self.existingObject(with: objectID) as? T else { return nil }
        guard !object.isDeleted else { return nil }
        return object
    }
    
}
