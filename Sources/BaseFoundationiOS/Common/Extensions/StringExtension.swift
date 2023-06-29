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
    
    public func translateCoreLocalizable() -> String {
        return NSLocalizedString(self,
                                 tableName: "BaseLocalizables",
                                 bundle: Bundle.module,
                                 comment: "")
    }
}
