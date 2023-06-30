//
//  OKChainResponse.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

open class OKChainResponse<T>: RESTAPIChainResponse, ErrorChain {
    override open func handle(response: APIResponse, isHandled handled: Bool, completionHandler: CompletionHandler) -> Bool {
        var handledVar = handled
        let statusCode = response.response?.statusCode

        if statusCode == self.okHttpCode || statusCode == self.createdHttpCode || statusCode == self.customHttpCode {
            handledVar = true
            self.breakForLinkFound()
            self.handleOk(response: response, completionHandler: completionHandler)
        }

        return super.handle(response: response, isHandled: handledVar, completionHandler: completionHandler)
    }

    open func handleOk(response: APIResponse, completionHandler: CompletionHandler) {
        guard self.isResponseValidationError(response: response, completionHandler: completionHandler) == false else {
            return
        }
        
        if let responseDict = response.value as? T {
            self.handleOk(dataDict: responseDict, completionHandler: completionHandler)
        } else {
            self.handleErrorResponse(response: response, completionHandler: completionHandler)
        }
    }

    open func handleOk(dataDict: T, completionHandler: CompletionHandler) {
        completionHandler(true, nil, dataDict)
    }
}
