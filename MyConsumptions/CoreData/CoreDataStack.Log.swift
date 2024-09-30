//
//  CoreDataLog.swift
//  WalletTestApp
//
//  Created by Grigory Sapogov on 31.03.2024.
//

import Foundation

extension CoreDataStack {
    
    final class Log {
        
        static let shared = Log()
        
        private init() {}
        
        func log(_ message: String) {
            #if DEBUG
            print(message)
            #endif
        }
        
    }
    
}
