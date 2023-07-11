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
    
    public func translateCoreLocalizable() -> String {
        return NSLocalizedString(self, bundle: Bundle.module, comment: "")
    }
    
    public func isFullEmpty() -> Bool {
        let trimmedString: String = self.trimmingCharacters(in: CharacterSet.whitespaces)
        return trimmedString.isEmpty
    }
}
