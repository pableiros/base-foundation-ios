//
//  NumberRule.swift
//  
//
//  Created by pablo borquez on 21/07/23.
//

import Foundation

open class NumberRule: BaseRule {
    open override func isValid(value: Any?) -> Bool {
        guard let str = value as? String else { return false }
        
        if self.isNullable && str.isFullEmpty() {
            return true
        } else {
            return Double(str) != nil || Float(str) != nil || Int(str) != nil
        }
    }
}
