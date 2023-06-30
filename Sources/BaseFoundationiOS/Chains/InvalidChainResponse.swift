//
//  InvalidChainResponse.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

class InvalidChainResponse: HandlerChainResponse {
    override func handleRequest(response: APIResponse, completionHandler: (Bool, String?, Any?) -> Void) {
        guard let responseDict = response.convertValueToResponseDict(),
              let notificacionDict = responseDict["notificacion"] as? [String: AnyObject],
              let mensaje = notificacionDict["mensaje"] as? String else {
            self.handleErrorResponse(response: response, completionHandler: completionHandler)
            return
        }

        completionHandler(false, mensaje, nil)
    }
}
