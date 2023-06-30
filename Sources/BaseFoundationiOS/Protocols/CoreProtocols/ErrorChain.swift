//
//  ErrorChain.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation
import Alamofire

public protocol ErrorChain where Self: RESTAPIChainResponse {
}

extension ErrorChain {
    public func getErrorMessage(response: APIResponse) -> String? {
        guard let responseDict = response.convertValueToResponseDict(),
              let mensaje = responseDict["message"] as? String else {
                  return nil
              }
        
        return mensaje
    }
    
    public func handleErrorResponse(response: APIResponse, completionHandler: CompletionHandler) {
        if let message = self.getErrorMessage(response: response) {
            completionHandler(false, message, nil)
        } else {
            self.handleInvalidResponse(completionHandler: completionHandler)
        }
    }
    
    public func handleInvalidResponse(completionHandler: CompletionHandler) {
        completionHandler(false, BaseLocalizables.internalServerError, nil)
    }
    
    public func isResponseValidationError(response: APIResponse, completionHandler: CompletionHandler) -> Bool {
        var isResponseValidationError = false
        
        if let responseDict = response.value as? [String: Any],
           let errorDict = responseDict["errors"] as? [String: Any] {
            let firstErrorIndex = errorDict.index(errorDict.startIndex, offsetBy: 0)
            let firstErrorKey = errorDict.keys[firstErrorIndex]
            
            if let errorValue = errorDict[firstErrorKey] as? [String] {
                completionHandler(false, errorValue.first, nil)
                isResponseValidationError = true
            }
        }
        
        return isResponseValidationError
    }
}
