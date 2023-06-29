//
//  BaseService.swift
//  
//
//  Created by pablo borquez on 28/06/23.
//

import Foundation
import Alamofire

open class BaseService: NSObject {
    public var headerAbstractFactory: BaseHeaderAbstractFactory?

    open func createHeaderForRequest(userHeaders: [String: String]?) -> HTTPHeaders? {
        var headersForRequest: [String: String] = userHeaders ?? [String: String]()
        var httpHeaders: HTTPHeaders?

        if let extraHeaders = self.headerAbstractFactory?.createExtraHeadersForRequest() {
            headersForRequest.update(extraHeaders)
        }

        if headersForRequest.count > 0 {
            httpHeaders = HTTPHeaders()

            headersForRequest.forEach { (key, value) in
                httpHeaders?.add(name: key, value: value)
            }
        }

        return httpHeaders
    }
}

