//
//  DocumentConsumptionListRowView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 30.09.2024.
//

import SwiftUI

struct DocumentConsumptionListRowView: View {
    
    var date: Date?
    
    var wallet: String?
    
    var states: [String]?
    
    var value: Decimal
    
    var stateComment: String?
    
    var comment: String?
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
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
                
                ValueView(value: value)
                    .font(.title)
                    .foregroundStyle(.consumption)
                
            }
            
            CommentView(comment: stateComment)
            
            CommentView(comment: comment)
                .lineLimit(2)
            
        }
        
    }
    
}

#Preview {
    NavigationStack {
        
        List {
            
            DocumentConsumptionListRowView(date: .now, wallet: "Wallet", value: 4000, stateComment: "test, test", comment: "Test")
            
        }
        
    }
}
