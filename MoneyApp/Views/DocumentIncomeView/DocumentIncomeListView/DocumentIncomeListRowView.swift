//
//  DocumentIncomeListRowView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 28.07.2024.
//

import SwiftUI

struct DocumentIncomeListRowView: View {
    
    var date: Date?
    
    var wallet: String?
    
    var states: [String]?
    
    var value: Decimal
    
    var body: some View {
        
        HStack(spacing: 8) {
            
            VStack(alignment: .leading, spacing: 8) {
                
                if let date = date {
                    Text(date.formatted())
                        .foregroundStyle(.secondary)
                }
                
                if let wallet = wallet {
                    Text(wallet)
                }
                
            }
            
            Spacer()
            
            Text("\(value)")
                .font(.title)
                .foregroundStyle(.green)
            
        }
        
    }
}

#Preview {
    NavigationStack {
        
        List {
            
            DocumentIncomeListRowView(date: .now, wallet: "Wallet", value: 4000)
            
        }
        
    }
}
