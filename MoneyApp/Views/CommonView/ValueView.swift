//
//  ValueView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 21.08.2024.
//

import SwiftUI

struct ValueView: View {
    
    let value: Decimal
    
    var body: some View {
        Text("\(value)")
            .font(.title)
            .foregroundStyle(.green)
    }
}

#Preview {
    ValueView(value: 1200.34)
}
