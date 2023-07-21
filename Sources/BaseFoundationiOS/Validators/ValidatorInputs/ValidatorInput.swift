//
//  ValidatorInput.swift
//  
//
//  Created by pablo borquez on 21/07/23.
//

import Foundation

open class ValidatorInput {
    public var value: Any?
    public var isValid: Bool = true
    public var rules: [ValidatorRule] = [ValidatorRule]()
    
    private(set) var message: String?
    
    public init(value: Any? = nil, rules: [ValidatorRule] = [ValidatorRule](), message: String? = nil) {
        self.value = value
        self.rules = rules
        self.message = message
    }
    
    public func validate() -> String? {
        for validatorRule in self.rules {
            let valueToValidate = self.getValueToValidate(validatorRule: validatorRule)
            self.isValid = validatorRule.isValid(value: valueToValidate)
            
            if self.isValid == false {
                self.message = validatorRule.message
                break
            }
        }
        
        return self.message
    }
    
    open func getValueToValidate(validatorRule: ValidatorRule) -> Any? {
        return self.value
    }
}
