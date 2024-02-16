//
//  StartEndDateRangeRule.swift
//  
//
//  Created by pablo borquez on 16/02/24.
//

import Foundation

open class StartEndDateRangeRule: BaseRule {
    override open func isValid(value: Any?) -> Bool {
        guard let tuple = value as? (Date?, Date?),
              let startDate = tuple.0,
              let endDate = tuple.1 else {
            return false
        }

        return startDate < endDate
    }
}
