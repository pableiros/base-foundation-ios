//
//  AppLogContainer.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

public struct AppLogContainer {
    public let tipoAppLog: TipoAppLog
    public let className: String?
    public let method: String?
    public let line: Int?
    public let message: Any?
    
    public func toContent() -> [String: Any] {
        var params = [String: Any]()
        
        if let method {
            params["method"] = method
        }
        
        if let className {
            params["class_name"] = className
        }
        
        if let line {
            params["line"] = line.toString()
        }
        
        if let message {
            if let messageString = (message as? String)?.toString() {
                params["message"] = messageString
            } else {
                params["message"] = "\(message)"
            }
        }
        
        return params
    }
}
