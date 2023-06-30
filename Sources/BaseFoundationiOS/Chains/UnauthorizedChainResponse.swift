//
//  UnauthorizedChainResponse.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

class UnauthorizedChainResponse: RESTAPIChainResponse, ErrorChain {
    override func handle(response: APIResponse, isHandled handled: Bool, completionHandler: CompletionHandler) -> Bool {
        var handledVar = handled

        if response.response?.statusCode == self.unauthorizedRequest {
            handledVar = true
            self.breakForLinkFound()
            AppConfiguration.shared.baseGlobalSession.handleSessionExpired()
            completionHandler(false, nil, nil)
        }

        return super.handle(response: response, isHandled: handledVar, completionHandler: completionHandler)
    }
}

