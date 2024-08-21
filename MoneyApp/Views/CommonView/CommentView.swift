//
//  CommentView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 28.07.2024.
//

import SwiftUI

struct CommentView: View {
    
//    @Binding var text: String?
    @Binding var text: String
    
//    @State private var test: String = "sdfs df s"
    
    var body: some View {
        
//        TextEditor(text: $text.defaultValue(""))
        TextEditor(text: $text)
//        TextField("Title", text: $text.defaultValue(""),  axis: .vertical)
//            .lineLimit(5...10)
//            .frame(minHeight: 100)
        
    }
}

//#Preview {
//    CommentView(text: .constant("comment"))
//}
