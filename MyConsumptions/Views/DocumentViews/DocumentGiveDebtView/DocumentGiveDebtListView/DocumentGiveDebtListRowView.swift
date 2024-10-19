//
//  DocumentGiveDebtListRowView.swift
//  MyConsumptions
//
//  Created by Grigory Sapogov on 19.10.2024.
//

import SwiftUI

struct DocumentGiveDebtListRowView: View {
    
    var date: Date?
    
    var contact: String?
    
    var debt: String?
    
    var value: Decimal
    
    var comment: String?
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            HStack(spacing: 8) {
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    if let date = date {
                        Text(date.formatted())
                            .foregroundStyle(.secondary)
                    }
                    
                }
                
                Spacer()
                
                ValueView(value: value)
                    .font(.title)
                    .foregroundStyle(.consumption)
                
            }
            
            if let contact = contact {
                Text(contact)
            }
            
            if let debt = debt {
                Text(debt)
            }
            
            CommentView(comment: comment)
                .lineLimit(2)
            
        }
        
    }
    
}

#Preview {
    NavigationStack {
        
        List {
            
            DocumentTransferListRowView(date: .now, walletFrom: "From", walletTo: "To", value: 1000, comment: "test")
            
        }
        
    }
}
