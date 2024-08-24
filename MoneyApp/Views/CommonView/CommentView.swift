//
//  CommentView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 28.07.2024.
//

import SwiftUI

struct CommentView: View {
    
    @Binding var text: String
    
    var body: some View {
        
        TextView(text: $text)
        
    }
}

//#Preview {
//    CommentView(text: .constant("comment"))
//}
