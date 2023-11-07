//
//  ValidatorDelegate.swift
//
//
//  Created by pablo borquez on 07/11/23.
//

import Foundation

public protocol ValidatorDelegate {
    func prepareValuesToValidate() -> [ValidatorInput]
}

extension ValidatorDelegate {
    public func validate() -> (isValid: Bool, message: String?) {
        let validatorInputArray = self.prepareValuesToValidate()
        var message: String?
        
        for validatorInput in validatorInputArray {
            let validationMessage = validatorInput.validate()

            if validationMessage != nil {
                message = validationMessage
                break
            }
        }
        
        return (isValid: message == nil, message: message)
    }
}
