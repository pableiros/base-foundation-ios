//
//  RequiredRule.swift
//  
//
//  Created by pablo borquez on 21/07/23.
//

import Foundation

open class RequiredRule: BaseRule {
    override open func isValid(value: Any?) -> Bool {
        let isValid: Bool

        if let value = value as? String {
            isValid = value.isFullEmpty() == false
        } else {
            isValid = value != nil
        }

        return isValid
    }
}
