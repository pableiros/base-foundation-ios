//
//  ConfigKey.swift
//
//
//  Created by pablo borquez on 07/07/23.
//

import Foundation

public struct ConfigKey {
    public static let endPointSelectedKey: String = "End Points Selected"
    public static let endPoints: String = "End Points"

    public static let domainsKey: String = "Domains"
    public static let uriKey: String = "URI"

    public static let apiKeys: String = "ApiKeys"
    public static let apiKeyKey: String = "api_key"
    public static let apiSecretKey: String = "api_secret"

    public static var domain: String { EndPointDomainKey.domain }
    public static var apiUriKey: String { EndPointDomainKey.apiUriKey }
    public static var user: String { EndPointDomainKey.user }
    public static var token: String { EndPointDomainKey.token }
    public static var sslPinningUrl: String { EndPointDomainKey.sslPinningUrl }
}
