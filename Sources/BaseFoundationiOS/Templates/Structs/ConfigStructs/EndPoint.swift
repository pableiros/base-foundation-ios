//
//  EndPoint.swift
//
//
//  Created by pablo borquez on 07/07/23.
//

import Foundation

public struct EndPoint {
    public var domains: [String: EndPointDomain] = [:]
    public var uris: [String: String] = [:]

    public static func createFromDictionary(dict: [String: Any]) -> EndPoint {
        guard let domainsDict = dict[ConfigKey.domainsKey] as? [String: Any],
              let urisDict = dict[ConfigKey.uriKey] as? [String: String] else {
            fatalError("Domains or URI not defined")
        }

        let domains: [String: EndPointDomain] = domainsDict.mapValues { (domainDict) -> EndPointDomain in
            EndPointDomain.createFromDictionary(dict: domainDict as! [String: Any])
        }

        return EndPoint(domains: domains, uris: urisDict)
    }
}
