//
//  EndPointApiKeys.swift
//
//
//  Created by pablo borquez on 07/07/23.
//

import Foundation

public struct EndPointApiKeys {
    public var apiKey: String?
    public var apiSecret: String?

    public static func createFromDictionary(dict: [String: Any]) -> EndPointApiKeys {
        return EndPointApiKeys(apiKey: dict[ConfigKey.apiKeyKey] as? String,
                               apiSecret: dict[ConfigKey.apiSecretKey] as? String)
    }
}
