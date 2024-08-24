//
//  ValueView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 21.08.2024.
//

import SwiftUI

struct ValueView: View {
    
    let value: Decimal?
    
    private var text: String {
        let value = self.value ?? 0
        let text = Model.decimalFormatter.string(from: value as NSNumber) ?? ""
        return text
        
    }
    
    var body: some View {
        Text("\(text)")
    }
    
}

#Preview {
    ValueView(value: 1200.34)
}


