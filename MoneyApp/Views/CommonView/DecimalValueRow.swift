//
//  DecimalValueRow.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 28.07.2024.
//

import SwiftUI

struct DecimalValueRow: View {
    
    @Binding var value: NSDecimalNumber?
    
    var body: some View {
        
        HStack {
            Text("Сумма")
            Spacer()
            TextFieldDecimal(value: $value)
                .font(.title)
                .foregroundStyle(.income)
               
        }
        
    }
}

#Preview {
    NavigationStack {
        List {
            DecimalValueRow(value: .constant(1000))
        }
    }
}
