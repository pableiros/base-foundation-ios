//
//  DataResponseExtension.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation
import Alamofire

extension DataResponse {
    func toAPIResponse(printRawResponse: Bool) -> APIResponse {
        var value: Any?
        
        if let data = self.value as? Data {
            do {
                value = try JSONSerialization.jsonObject(with: data)
            } catch {
                MainLogger.shared?.error(error,
                                     className: String(describing: self),
                                     method: #function,
                                     line: #line)
            }
        } else {
            value = self.value
        }
        
        self.printResponse(value: value, printRawResponse: printRawResponse)
        
        return APIResponse(response: self.response, request: self.request, value: value)
    }
    
    private func printResponse(value: Any?, printRawResponse: Bool) {
        #if DEBUG
        if let dict = value as? [String: Any] {
            MainLogger.shared?.printBaseRESTAPI("REST Response: \(dict.toJSONText())")
        } else if let array = value as? [[String: Any]] {
            MainLogger.shared?.printBaseRESTAPI("REST Response: \(array.toJSONText())")
        } else {
            MainLogger.shared?.printBaseRESTAPI("REST Response: \(value ?? "nil")")
        }
        
        if printRawResponse {
            var data: Data?
            
            if let responseData = self.data {
                data = responseData
            } else if case .success(let responseData) = self.result,
                      let responseData = responseData as? Data {
                data = responseData
            }
            
            if let data = data, let utf8Text = String(data: data, encoding: .utf8) {
                MainLogger.shared?.printBaseRESTAPI("Raw response: \(utf8Text)")
            }
        }
        #endif
    }
}
