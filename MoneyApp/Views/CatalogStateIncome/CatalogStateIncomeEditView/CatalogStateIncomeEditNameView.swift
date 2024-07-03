//
//  CatalogStateIncomeEditNameView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 03.07.2024.
//

import SwiftUI

struct CatalogStateIncomeEditNameView: View {
    
    @Binding var name: String
    
    var body: some View {
        TextField(text: $name) {
            Text("Наименование")
        }
    }
}

#Preview("Empty", body: {
    CatalogStateIncomeEditNameView(name: .constant(""))
})

#Preview("State 1", body: {
    CatalogStateIncomeEditNameView(name: .constant("State 1"))
})

