//
//  CommentView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 26.08.2024.
//

import SwiftUI

struct CommentView: View {
    
    var comment: String?
    
    var body: some View {
        if let comment = comment, !comment.isEmpty {
            Text(comment)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    CommentView()
}
