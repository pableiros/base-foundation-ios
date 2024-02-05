//
//  SelectableRule.swift
//
//
//  Created by pablo borquez on 05/02/24.
//

import Foundation

open class SelectableRule: BaseRule {
    override open func isValid(value: Any?) -> Bool {
        value != nil
    }
}
