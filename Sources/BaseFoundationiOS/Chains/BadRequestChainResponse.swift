//
//  BadRequestChainResponse.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

class BadRequestChainResponse: InvalidChainResponse {
    override func isStatusCodeToHandle(statusCode: Int?) -> Bool {
        return statusCode == self.badRequest
    }
}
