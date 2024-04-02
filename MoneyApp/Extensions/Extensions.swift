//
//  Extensions.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 02.04.2024.
//

import SwiftUI

extension Binding {
    
    func defaultValue<T>(_ defaultValue: T) -> Binding<T> where Value == T? {
        
        guard let wrappedValue = self.wrappedValue else {
            return Binding<T> {
                defaultValue
            } set: { newValue in
                self.wrappedValue = newValue
            }

        }
        
        return Binding<T> {
            wrappedValue
        } set: { newValue in
            self.wrappedValue = newValue
        }
        
        
    }
    
    
}
