//
//  FormViewValidatorDelegate.swift
//
//
//  Created by pablo borquez on 12/11/23.
//

import Foundation

public protocol FormViewValidatorDelegate {
    var formState: FormState { get set }
    
    func submitForm() async
    func set(errorMessage: String)
}
extension FormViewValidatorDelegate {
    public func validateForm(container: ValidatorDelegate) {
        let validationResult = container.validate()
        
        if validationResult.isValid {
            Task {
                await self.submitForm()
            }
        } else if let message = validationResult.message {
            self.set(errorMessage: message)
        }
    }
}
