//
//  File.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

class ForbiddenChainResponse: OKChainResponse<[String: Any]> {
    required init() {
        super.init()
        self.customHttpCode = self.forbidden
    }
    
    override func handleOk(response: APIResponse, completionHandler: (Bool, String?, Any?) -> Void) {
        self.handleErrorResponse(response: response, completionHandler: completionHandler)
    }
}
