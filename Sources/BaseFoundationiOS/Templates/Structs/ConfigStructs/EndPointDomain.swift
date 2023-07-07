//
//  EndPointDomain.swift
//  
//
//  Created by pablo borquez on 07/07/23.
//

import Foundation

public struct EndPointDomain {
    public static let main = "Main"

    public var domain: String?
    public var apiUri: String?
    public var sslPinningUrl: String?
    public var token: String?

    public var apiKeys: EndPointApiKeys?

    public static func createFromDictionary(dict: [String: Any]) -> EndPointDomain {
        var endPointApiKeys: EndPointApiKeys?

        if let apiKeysDict = dict[ConfigKey.apiKeys] as? [String: Any] {
            endPointApiKeys = EndPointApiKeys.createFromDictionary(dict: apiKeysDict)
        }

        return EndPointDomain(domain: dict[ConfigKey.domain] as? String,
                              apiUri: dict[ConfigKey.apiUriKey] as? String,
                              sslPinningUrl: dict[ConfigKey.sslPinningUrl] as? String,
                              token: dict[ConfigKey.token] as? String,
                              apiKeys: endPointApiKeys)
    }
}
