//
//  InternalServerErrorChainResponse.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

class InternalServerErrorChainResponse: RESTAPIChainResponse, ErrorChain {
    let httpCode = 500
    let maxHttpCode = 511

    override func handle(response: APIResponse, isHandled handled: Bool, completionHandler: CompletionHandler) -> Bool {
        var handledVar = handled

        if response.response!.statusCode >= self.httpCode && response.response!.statusCode <= self.maxHttpCode {
            handledVar = true
            self.breakForLinkFound()
            self.handleErrorResponse(response: response, completionHandler: completionHandler)
        }

        return super.handle(response: response, isHandled: handledVar, completionHandler: completionHandler)
    }
}
