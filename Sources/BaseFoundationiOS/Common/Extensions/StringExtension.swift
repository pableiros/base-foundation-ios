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
    public var required: String {
        return "\(self)*"
    }
    
    public func toNSString() -> NSString {
        return NSString(string: self)
    }
    
    public  func toDouble() -> Double {
        return Double(self) ?? 0
    }
    
    public func translateCoreLocalizable() -> String {
        return NSLocalizedString(self, bundle: Bundle.module, comment: "")
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
}
