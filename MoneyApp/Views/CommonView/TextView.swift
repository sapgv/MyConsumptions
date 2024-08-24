//
//  TextView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 24.08.2024.
//

import SwiftUI
import UIKit

struct TextView: UIViewRepresentable {
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView(frame: .zero)
        textView.text = self.text
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = self.text
    }

    func makeCoordinator() -> TextView.Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject {
        
        var parent: TextView
        
        init(parent: TextView) {
            self.parent = parent
        }
        
    }
    
}

extension TextView.Coordinator: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        self.parent.text = textView.text
    }
    
}
    
