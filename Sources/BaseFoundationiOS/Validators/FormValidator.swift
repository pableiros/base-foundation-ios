//
//  File.swift
//  
//
//  Created by pablo borquez on 21/07/23.
//

import Foundation

public protocol FormValidator: AnyObject {
    func prepareValuesToValidate() -> [ValidatorInput]
}

extension FormValidator {
    public func validateForm() async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) -> Void in
            self.validateForm { success, message, _ in
                if success {
                    continuation.resume()
                } else {
                    continuation.throwing(message: message)
                }
            }
        }
    }
    
    func validateForm(completionHandler: @escaping CompletionHandler) {
        DispatchQueue.global(qos: .userInitiated).async {
            let valuesToValidate = self.prepareValuesToValidate()
            let message: String? = self.performValidateForm(valuesToValidate: valuesToValidate)

            completionHandler(message == nil, message, nil)
        }
    }
    
    // MARK: - private
    
    private func performValidateForm(valuesToValidate: [ValidatorInput]) -> String? {
        var message: String?

        valuesToValidate.forEach { validatorInput in
            let validationMessage = validatorInput.validate()

            if message == nil {
                message = validationMessage
            }
        }

        return message
    }
}
