//
//  DocumentTransferListRowView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 30.09.2024.
//

import SwiftUI

struct DocumentTransferListRowView: View {
    
    var date: Date?
    
    var walletFrom: String?
    
    var walletTo: String?
    
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
                    .foregroundStyle(.transfer)
                
            }
            
            HStack {
                if let walletFrom = walletFrom {
                    VStack(alignment: .leading) {
                        Text(walletFrom)
                        Text("Откуда")
                            .foregroundStyle(.secondary)
                    }
                }
                Spacer()
                if let walletTo = walletTo {
                    VStack(alignment: .trailing) {
                        Text(walletTo)
                        Text("Куда")
                            .foregroundStyle(.secondary)
                    }
                }
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
