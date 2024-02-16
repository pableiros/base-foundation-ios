//
//  FormViewValidatorDelegate.swift
//
//
//  Created by pablo borquez on 12/11/23.
//

import Foundation

public protocol FormViewValidatorDelegate {
    associatedtype Container: ValidatorDelegate
    
    var formState: FormState { get set }
    
    func submitForm(container: Container) async
    func set(errorMessage: String)
}
extension FormViewValidatorDelegate {
    public func validateForm(container: Container) {
        let validationResult = container.validate()
        
        if validationResult.isValid {
            Task {
                await self.submitForm(container: container)
            }
        } else if let message = validationResult.message {
            self.set(errorMessage: message)
        }
    }
}
