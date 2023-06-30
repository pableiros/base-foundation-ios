//
//  APIResponse.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

public struct APIResponse {
    public var response: HTTPURLResponse?
    public var request: URLRequest?
    public var value: Any?
    
    public var httpCode: Int? {
        return self.response?.statusCode
    }
    
    public func convertValueToResponseDict() -> [String: Any]? {
        var responseDict: [String: Any]?
        
        if let dict: [String: Any] = self.value as? [String: Any] {
            responseDict = dict
        } else if let responseString: String = self.value as? String {
            let jsonManager: JSONManager = JSONManager()
            responseDict = jsonManager.createDictionary(from: responseString)
        }
        
        return responseDict
    }
}
