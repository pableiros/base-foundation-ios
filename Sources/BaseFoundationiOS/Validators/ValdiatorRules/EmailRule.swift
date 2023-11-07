//
//  EmailRule.swift
//
//
//  Created by pablo borquez on 07/11/23.
//

import Foundation

open class EmailRule: BaseRule {
    override open func isValid(value: Any?) -> Bool {
        guard let str = value as? String else { return false }

        return str.isEmail()
    }
}
