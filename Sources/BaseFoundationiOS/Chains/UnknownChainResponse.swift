//
//  UnknownChainResponse.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

class UnknownChainResponse: RESTAPIChainResponse, ErrorChain {
    override func handle(response: APIResponse, isHandled handled: Bool, completionHandler: CompletionHandler) -> Bool {
        var handledVar: Bool = handled

        if handledVar == false {
            handledVar = true
            self.breakForLinkFound()
            self.handleErrorResponse(response: response, completionHandler: completionHandler)
        }

        return super.handle(response: response, isHandled: handledVar, completionHandler: completionHandler)
    }
}
