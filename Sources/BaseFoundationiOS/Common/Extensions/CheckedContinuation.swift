//
//  CheckedContinuation.swift
//  
//
//  Created by pablo borquez on 29/06/23.
//

import Foundation

extension CheckedContinuation where E == Error {
    public func throwing(message: String?) {
        let error: String
        
        if let message = message {
            error = message
        } else {
            error = BaseLocalizables.internalServerError
        }
        
        self.resume(throwing: error)
    }
}
