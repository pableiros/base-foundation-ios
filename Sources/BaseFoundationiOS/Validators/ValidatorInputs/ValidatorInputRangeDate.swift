//
//  ValidatorInputRangeDate.swift
//
//
//  Created by pablo borquez on 16/02/24.
//

import Foundation

public class ValidatorInputRangeDate: ValidatorInput {
    public var startDate: Date? {
        didSet {
            self.value = self.startDate
        }
    }
    
    public var endDate: Date?
    
    public override func getValueToValidate(validatorRule: ValidatorRule) -> Any? {
        let value: Any?

        if validatorRule is StartEndDateRangeRule {
            value = (self.startDate, self.endDate)
        } else {
            value = super.getValueToValidate(validatorRule: validatorRule)
        }

        return value
    }
}
