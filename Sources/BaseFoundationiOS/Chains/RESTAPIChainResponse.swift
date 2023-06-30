//
//  RESTAPIChainResponse.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

open class RESTAPIChainResponse {
    public var nextResponse: RESTAPIChainResponse?
    public var afterCompletion: (() -> Void)?
    public var anyObjectPassed: Any?
    public var customHttpCode = 0

    public var processId: String?

    let okHttpCode = 200
    let createdHttpCode = 201
    let badRequest = 400
    let unauthorizedRequest = 401
    let forbidden = 403
    let notFoundRequest = 404
    let conflictResponse = 409
    let preFailedResponse = 412

    required public init() { }

    class func create(chain chainResponseClases: [RESTAPIChainResponse.Type],
                      with anyObjectPassed: Any?,
                      processId: String?) -> RESTAPIChainResponse? {
        var restApiChainResponse: RESTAPIChainResponse?

        for typeClass: RESTAPIChainResponse.Type in chainResponseClases.reversed() {
            let existingLink: RESTAPIChainResponse? = restApiChainResponse
            restApiChainResponse = typeClass.init()
            restApiChainResponse?.nextResponse = existingLink
            restApiChainResponse?.anyObjectPassed = anyObjectPassed
            restApiChainResponse?.processId = processId
        }

        return restApiChainResponse
    }

    open func handle(response: APIResponse, isHandled handled: Bool = false, completionHandler: CompletionHandler) -> Bool {
        if self.nextResponse != nil {
            return (self.nextResponse?.handle(response: response, isHandled: handled, completionHandler: completionHandler))!
        } else if !handled {
            completionHandler(false, "", nil)
        }

        return handled
    }

    public func breakForLinkFound() {
        self.nextResponse = nil
    }
}
