//
//  BaseProcessInfoHelper.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

open class BaseProcessInfoHelper {
    public init() {
    }
    
    public func getValue(fromKey key: String, withDefault defaultValue: String) -> String {
        let dict: [String: String] = ProcessInfo.processInfo.environment
        let value: String

        if let domain: String = dict[key] {
            value = domain
        } else {
            value = defaultValue
        }

        return value
    }

    public func isEnvironmentVariableSet(key: String) -> Bool {
        var isSet: Bool = false

        if let value = ProcessInfo.processInfo.environment[key] {
            isSet = value == "1"
        }

        return isSet
    }
}
