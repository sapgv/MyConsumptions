//
//  CommentTextView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 28.07.2024.
//

import SwiftUI

struct CommentTextView: View {
    
    @Binding var text: String
    
    var body: some View {
        
        TextView(text: $text)
        
    }
}

#Preview {
    CommentTextView(text: .constant("comment"))
}
