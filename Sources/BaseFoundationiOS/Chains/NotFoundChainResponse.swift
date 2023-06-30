//
//  NotFoundChainResponse.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

class NotFoundChainResponse: HandlerChainResponse {
    static let notFound = "not-found"
    
    required init() {
        super.init()
        self.customHttpCode = self.notFoundRequest
    }
    
    override func handleRequest(response: APIResponse, completionHandler: (Bool, String?, Any?) -> Void) {
        completionHandler(false, self.getErrorMessage(response: response), NotFoundChainResponse.notFound)
    }
    
    override func isStatusCodeToHandle(statusCode: Int?) -> Bool {
        return statusCode == self.notFoundRequest
    }
}
