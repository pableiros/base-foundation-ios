//
//  NumberRuleDataSource.swift
//
//
//  Created by pablo borquez on 24/06/24.
//

import Foundation

public protocol NumberRuleDataSource {
}

extension NumberRuleDataSource {
    public func createNumberValidator(valueRaw: String,
                                      requiredMessage: String,
                                      numberMessage: String,
                                      isNullable: Bool = false) -> ValidatorInput {
        let validatorInput = ValidatorInput()
        validatorInput.value = valueRaw
        
        if isNullable == false {
            validatorInput.rules.append(RequiredRule(message: requiredMessage))
        }
        
        validatorInput.rules.append(
            NumberRule(message: numberMessage, isNullable: isNullable)
        )
        
        return validatorInput
    }
}
