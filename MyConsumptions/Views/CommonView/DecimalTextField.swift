//
//  DecimalTextField.swift
//  iMoneyUI
//
//  Created by Grigory Sapogov on 27.02.2024.
//  Copyright © 2024 sapgv. All rights reserved.
//

import UIKit

public protocol DecimalTextFieldDelegate: AnyObject {
    func didChange(value: Double, in textField: DecimalTextField)
}

open class DecimalTextField: UITextField, UITextFieldDelegate {
    
    open var numberFormatter: NumberFormatter
    
    private var groupSeparatorsBefore: Int = 0
    
    private var isDeletion: Bool = false
    
    private var rangeBefore: UITextRange? = nil
    
    private var decimals: Int {
        self.numberFormatter.maximumFractionDigits
    }
    
    open weak var decimalTextFieldDelegate: DecimalTextFieldDelegate?
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
    }
    
    public init(numberFormatter: NumberFormatter = Model.decimalFormatter) {
        self.numberFormatter = numberFormatter
        super.init(frame: .zero)
        self.delegate = self
        self.setup()
    }
    
    public required init?(coder: NSCoder) {
        self.numberFormatter = Model.decimalFormatter
        super.init(coder: coder)
        self.delegate = self
        self.setup()
    }
    
    open func setup() {
        self.addTarget(self, action: #selector(valueChanged(_:)), for: .editingChanged)
    }

    open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        self.isDeletion = string.isEmpty
        self.rangeBefore = self.selectedTextRange
        
        guard let text = textField.text else { return false }
        guard let textRange = Range(range, in: text) else { return false }
        
        self.groupSeparatorsBefore = text.numberOfOccurrencesOf(string: numberFormatter.groupingSeparator)
        
        if !text.isEmpty, string.isEmpty {
            
            let replacingText = text.substring(with: range.location...range.location)
            
            if replacingText == " " {
                if let rangeBefore = self.rangeBefore, let newPosition = self.position(from: rangeBefore.start, offset: -1) {
                    self.selectedTextRange = self.textRange(from: newPosition, to: newPosition)
                }
                return true
            }
            
        }
        
        let newText = text.replacingCharacters(in: textRange, with: string)
        
        let decimalComponent = text.decimalComponent(of: numberFormatter.decimalSeparator)
        let newDecimalComponent = newText.decimalComponent(of: numberFormatter.decimalSeparator)
        
        if decimalComponent.count == decimals {
            if newDecimalComponent.count > decimalComponent.count {
                return false
            }
        }
        
        if string == numberFormatter.decimalSeparator && text.contains(numberFormatter.decimalSeparator) {
            return false
        }
        else if string == numberFormatter.decimalSeparator && decimals == 0 {
            return false
        }
        else if string == numberFormatter.decimalSeparator && text.isEmpty {
            self.text = "0" + numberFormatter.decimalSeparator
            return false
        }
        
        if !text.isEmpty && string == "0", range.location == 0 {
            return false
        }
        
        return true
        
    }
    
}

extension DecimalTextField {
    
    @objc
    private func valueChanged(_ textField: UITextField) {
        
        defer {
            if let value = self.text?.double {
                self.decimalTextFieldDelegate?.didChange(value: value, in: self)
            }
            else if (self.text ?? "").isEmpty {
                self.decimalTextFieldDelegate?.didChange(value: 0, in: self)
            }
        }
        
        guard let text = self.text else {
            return
        }
        
        let textWithoutGroup = text.replacingOccurrences(of: numberFormatter.groupingSeparator, with: "")
        
        if let number = numberFormatter.number(from: textWithoutGroup), let formattedText = numberFormatter.string(from: number) {
            
            let groupSeparatorsAfter = formattedText.numberOfOccurrencesOf(string: numberFormatter.groupingSeparator)
            
            let lastIsDecimalSeparator = (textWithoutGroup.last?.description == numberFormatter.decimalSeparator)
            
            var additional: String = ""
            if lastIsDecimalSeparator {
                additional = numberFormatter.decimalSeparator ?? ""
            }
            else {
                let componentsSeparator = textWithoutGroup.components(separatedBy: numberFormatter.decimalSeparator)
                
                if componentsSeparator.count == 2 {
                    additional = numberFormatter.decimalSeparator + componentsSeparator[1].prefix(decimals)
                }
            }
            
            self.text = formattedText.integerComponent(of: numberFormatter.decimalSeparator) + additional
            
            var offset: Int = 0
            if isDeletion {
                offset = (groupSeparatorsAfter < groupSeparatorsBefore ? -1 : 0) - 1
            }
            else {
                offset = (groupSeparatorsAfter > groupSeparatorsBefore ? 1 : 0) + 1
            }
            
            if let rangeBefore = self.rangeBefore, let newPosition = self.position(from: rangeBefore.start, offset: offset) {
                self.selectedTextRange = self.textRange(from: newPosition, to: newPosition)
            }
            
        }
        
    }
    
}
