//
//  String + Extensions.swift
//  iMoneyUI
//
//  Created by Grigory Sapogov on 27.02.2024.
//  Copyright © 2024 sapgv. All rights reserved.
//

import Foundation
import CommonCrypto

extension String {
    
    var double: Double? {
        return Model.decimalFormatter.number(from: self)?.doubleValue
    }
    
    var sha1Base64: String {
        let data = Data(self.utf8)
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA1($0.baseAddress, CC_LONG(data.count), &digest)
        }
        return Data(digest).base64EncodedString()
    }
    
    func decimalComponent(of separator: String) -> String {
        let componentsSeparator = self.components(separatedBy: separator)
        if componentsSeparator.count == 2 {
            return componentsSeparator[1]
        }
        return ""
    }
    
    func numberOfOccurrencesOf(string: String) -> Int {
        return self.components(separatedBy:string).count - 1
    }
    
    func integerComponent(of separator: String) -> String {
        let componentsSeparator = self.components(separatedBy: separator)
        return componentsSeparator.first ?? ""
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    func substring(with r: ClosedRange<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex...endIndex])
    }
    
    func range(with r: Range<Int>) -> Range<String.Index>{
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return startIndex..<endIndex
    }
    
    func range(with r: ClosedRange<Int>) -> ClosedRange<String.Index>{
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return startIndex...endIndex
    }
    
}
