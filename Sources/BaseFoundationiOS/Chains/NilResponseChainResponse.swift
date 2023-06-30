//
//  NilResponseChainResponse.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

class NilResponseChainResponse: RESTAPIChainResponse, ErrorChain {
    override func handle(response: APIResponse, isHandled handled: Bool, completionHandler: CompletionHandler) -> Bool {
        var handledVar = handled

        if response.response == nil {
            handledVar = true
            self.breakForLinkFound()
            completionHandler(false, BaseLocalizables.serverUnreachable, nil)
        }

        return super.handle(response: response, isHandled: handledVar, completionHandler: completionHandler)
    }
}
