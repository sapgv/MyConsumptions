//
//  CommentView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 28.07.2024.
//

import SwiftUI

struct CommentView: View {
    
    @Binding var text: String?
    
    var body: some View {
        
        TextEditor(text: $text.defaultValue(""))
            .frame(minHeight: 100)
        
    }
}

#Preview {
    CommentView(text: .constant("comment"))
}
