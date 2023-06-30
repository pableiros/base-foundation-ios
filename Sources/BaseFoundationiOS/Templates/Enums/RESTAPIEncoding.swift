//
//  File.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation
import Alamofire

public enum RESTAPIEncoding {
    case url
    case json
    case queryString
    case httpBody

    func getAlamofireEncoding() -> ParameterEncoding {
        let parameterEncoding: ParameterEncoding

        switch self {
        case .url:
            parameterEncoding = URLEncoding.default
        case .json:
            parameterEncoding = JSONEncoding.default
        case .queryString:
            parameterEncoding = URLEncoding.queryString
        case .httpBody:
            parameterEncoding = URLEncoding.httpBody
        }

        return parameterEncoding
    }

    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        return try self.getAlamofireEncoding().encode(urlRequest, with: parameters)
    }
}
