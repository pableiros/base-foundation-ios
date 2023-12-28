//
//  ArrayRule.swift
//
//
//  Created by pablo borquez on 28/12/23.
//

import Foundation

open class ArrayRule<Content>: BaseRule {
    override open func isValid(value: Any?) -> Bool {
        guard let array = value as? [Content] else { return false }

        return array.isEmpty == false
    }
}
