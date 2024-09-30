//
//  DocumentDatePicker.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 30.09.2024.
//

import SwiftUI

struct DocumentDatePicker: View {
    
    @Binding var date: Date?
    
    var body: some View {
        
        DatePicker(
            "Дата",
            selection: $date.defaultValue(.now),
            displayedComponents: [.hourAndMinute, .date]
        )
        .environment(\.locale, Locale(identifier: "ru"))
        
    }
    
}

#Preview {
    DocumentDatePicker(date: .constant(.now))
}
