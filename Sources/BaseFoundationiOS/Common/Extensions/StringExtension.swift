//
//  StringExtension.swift
//  
//
//  Created by pablo borquez on 27/06/23.
//

import Foundation

extension String: Error {
}

extension String {
    public var isNumber: Bool {
        return self.isInt || Double(self) != nil
    }
    
    public var isInt: Bool {
        return Int(self) != nil
    }
    
    public var required: String {
        return "\(self)*"
    }
    
    public func toNSString() -> NSString {
        return NSString(string: self)
    }
    
    public func toInt() -> Int {
        return Int(self) ?? 0
    }
    
    public func toDouble() -> Double {
        return Double(self) ?? 0
    }
    
    public func translateCoreLocalizable() -> String {
        return NSLocalizedString(self, bundle: Bundle.module, comment: "")
    }
    
    public func isEmail() -> Bool {
        let regex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return predicate.evaluate(with: self)
    }
    
    public func isFullEmpty() -> Bool {
        let trimmedString: String = self.trimmingCharacters(in: CharacterSet.whitespaces)
        return trimmedString.isEmpty
    }
    
    public func toDate() -> Date? {
        return Date.createFromUTC(yyyyMMddHHmmss: self)
    }
    
    public func ddMMyyyyToDate() -> Date? {
        return Date.createFromddMMyyyy(self)
    }
    
    public func toCommaSeparated() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale(identifier: "es_MX")
        
        let double = self.toDouble()
        let number = NSNumber(value: double)
        
        return numberFormatter.string(from: number) ?? double.toString()
    }
    
    public func removeLastThreeIfZeroes() -> String {
        guard self.hasSuffix(".00") else { return self }
        
        let endIndex = self.index(self.endIndex, offsetBy: -3)
        return String(self[..<endIndex])
    }
}
