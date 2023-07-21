//
//  File.swift
//  
//
//  Created by pablo borquez on 21/07/23.
//

import Foundation

open class BaseRule: ValidatorRule {
    public var message: String?
    public var isNullable: Bool = false

    public init(message: String, isNullable: Bool = false) {
        self.message = message
        self.isNullable = isNullable
    }
    
    public init(message: String) {
        self.message = message
    }

    open func isValid(value: Any?) -> Bool {
        fatalError("to override")
    }
}
