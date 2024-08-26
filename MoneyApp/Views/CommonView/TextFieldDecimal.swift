//
//  TextFieldDecimal.swift
//  iMoneyUI
//
//  Created by Grigory Sapogov on 22.02.2024.
//  Copyright © 2024 sapgv. All rights reserved.
//

import SwiftUI
import UIKit

struct TextFieldDecimal: UIViewRepresentable {
    
    @Binding var value: NSDecimalNumber?
    
    private var fontRepresentable: Font = .body
    
    private var representableTextColor: Color = .primary
    
    private let numberFormatter: NumberFormatter
    
    private let textAlignment: NSTextAlignment
    
    init(value: Binding<NSDecimalNumber?>,
         numberFormatter: NumberFormatter = Model.decimalFormatter,
         textAlignment: NSTextAlignment = .right
    ) {
        self._value = value
        self.numberFormatter = numberFormatter
        self.textAlignment = textAlignment
    }
    
    func makeUIView(context: Context) -> DecimalTextField {
        let textField = DecimalTextField(numberFormatter: Model.decimalFormatter)
        textField.keyboardType = .decimalPad
        textField.textAlignment = self.textAlignment
        textField.decimalTextFieldDelegate = context.coordinator
        textField.text = (self.value ?? 0).decimalValue.cleanFormatted
        textField.font = UIFont.preferredFont(from: self.fontRepresentable)
        textField.textColor = UIColor(self.representableTextColor)
        return textField
    }
    
    func updateUIView(_ uiView: DecimalTextField, context: Context) {
        guard let value = uiView.text?.double else { return }
        let decimal = NSDecimalNumber(value: value)
        guard decimal != self.value && self.value != 0 else { return }
        uiView.text = Model.decimalFormatter.string(from: decimal)
    }
    
    func makeCoordinator() -> TextFieldDecimal.Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate, DecimalTextFieldDelegate {
        
        var parent: TextFieldDecimal
        
        init(parent: TextFieldDecimal) {
            self.parent = parent
        }
        
        func didChange(value: Double, in textField: DecimalTextField) {
            self.parent.value = NSDecimalNumber(value: value)
        }
        
    }
    
    
    
}

extension TextFieldDecimal {
    
    func font(_ font: Font) -> TextFieldDecimal {
        var view = self
        view.fontRepresentable = font
        return view
    }
    
    func foregroundStyle(_ style: Color) -> TextFieldDecimal {
        var view = self
        view.representableTextColor = style
        return view
    }
    
}


