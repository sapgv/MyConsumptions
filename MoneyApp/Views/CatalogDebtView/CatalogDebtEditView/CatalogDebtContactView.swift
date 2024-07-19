//
//  CatalogDebtContactView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 19.07.2024.
//

import SwiftUI

struct CatalogDebtContactView: View {
    
    var name: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(name ?? "")
            Text("Контакт")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    NavigationStack {
        List {
            CatalogDebtContactView()
        }
    }
}
