//
//  FormViewValidatorDelegate.swift
//
//
//  Created by pablo borquez on 12/11/23.
//

import Foundation

public protocol FormViewValidatorDelegate {
    var errorMessage: String { get set }
    
    func submitForm()
    func set(errorMessage: String)
}
extension FormViewValidatorDelegate {
    public func validateForm(container: ValidatorDelegate) {
        let validationResult = container.validate()
        
        if validationResult.isValid {
            self.submitForm()
        } else if let message = validationResult.message {
            self.set(errorMessage: message)
        }
    }
}