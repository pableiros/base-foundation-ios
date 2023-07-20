//
//  LocalizableProtocol.swift
//  
//
//  Created by pablo borquez on 20/07/23.
//

import Foundation

public protocol LocalizableProtocol: RawValueDataSource {
}

extension LocalizableProtocol {
    public var translate: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
    
    public func translate(with arguments: Self...) -> String {
        String(format: self.translate, arguments: arguments.map { $0.translate })
    }
    
    public func translate(with arguments: String...) -> String {
        String(format: self.translate, arguments: arguments)
    }
}
