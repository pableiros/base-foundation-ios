//
//  HandlerChainResponse.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

class HandlerChainResponse: RESTAPIChainResponse, ErrorChain {
    override func handle(response: APIResponse, isHandled handled: Bool, completionHandler: CompletionHandler) -> Bool {
        var handledVar = handled

        if self.isStatusCodeToHandle(statusCode: response.response?.statusCode) {
            handledVar = true
            self.breakForLinkFound()
            self.handleRequest(response: response, completionHandler: completionHandler)
        }

        return super.handle(response: response, isHandled: handledVar, completionHandler: completionHandler)
    }

    func isStatusCodeToHandle(statusCode: Int?) -> Bool {
        fatalError("to override")
    }

    func handleRequest(response: APIResponse, completionHandler: CompletionHandler) {
        fatalError("to override")
    }
}
