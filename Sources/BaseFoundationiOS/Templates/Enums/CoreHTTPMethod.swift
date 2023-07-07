//
//  HTTPMethod.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation
import Alamofire

public enum CoreHTTPMethod {
    case connect
    case delete
    case get
    case head
    case options
    case patch
    case post
    case put
    case trace

    public func getRawValue() -> String {
        return self.getAlamofireValue().rawValue
    }

    public func getAlamofireValue() -> Alamofire.HTTPMethod {
        let alamofireHttpMethod: Alamofire.HTTPMethod

        switch self {
        case .connect:
            alamofireHttpMethod = Alamofire.HTTPMethod.connect
        case .delete:
            alamofireHttpMethod = Alamofire.HTTPMethod.delete
        case .get:
            alamofireHttpMethod = Alamofire.HTTPMethod.get
        case .head:
            alamofireHttpMethod = Alamofire.HTTPMethod.head
        case .options:
            alamofireHttpMethod = Alamofire.HTTPMethod.options
        case .patch:
            alamofireHttpMethod = Alamofire.HTTPMethod.patch
        case .post:
            alamofireHttpMethod = Alamofire.HTTPMethod.post
        case .put:
            alamofireHttpMethod = Alamofire.HTTPMethod.put
        case .trace:
            alamofireHttpMethod = Alamofire.HTTPMethod.trace
        }

        return alamofireHttpMethod
    }
}
