//
//  EditNameView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 03.07.2024.
//

import SwiftUI

struct EditNameView: View {
    
    @Binding var name: String
    
    var body: some View {
        TextField(text: $name) {
            Text("Наименование")
        }
    }
}

#Preview("Empty", body: {
    EditNameView(name: .constant(""))
})

#Preview("Name", body: {
    EditNameView(name: .constant("Name"))
})

#Preview("List", body: {
    NavigationStack {
        List {
            EditNameView(name: .constant("List"))
        }
    }
})

