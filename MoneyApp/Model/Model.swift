//
//  Model.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 02.04.2024.
//

import Foundation

public final class Model {
    
    static let coreData: CoreDataStack = CoreDataStack(modelName: "Model")

    public static let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
}
