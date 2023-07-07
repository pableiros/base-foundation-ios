//
//  EndPointManager.swift
//  
//
//  Created by pablo borquez on 07/07/23.
//

import Foundation

open class EndPointManager {
    private lazy var configContainer: ConfigContainer = ConfigContainer()

    open var endPointSelected: String = "Main"
    open var envSelected: String?

    open func getURL(forKey key: RawValueDataSource) -> String {
        self.getURL(forKey: key.rawValue)
    }

    open func getURL(forKey key: String) -> String {
        guard let endPoint = self.getEndPoint() else {
            fatalError("End Point not found")
        }

        guard let uri = endPoint.uris[key] else {
            fatalError("URI not found")
        }
        
        guard let domainSelected = self.getDomainSelected(),
              let domain = domainSelected.domain,
              var url = URL(string: domain) else {
            fatalError("End Point not found")
        }

        if let apiUri = domainSelected.apiUri, apiUri.isFullEmpty() == false {
            url.appendPathComponent(apiUri)
        }

        url.appendPathComponent(uri)

        return url.absoluteString
    }

    open func getEndPoint() -> EndPoint? {
        return self.configContainer.endPoints[self.endPointSelected]
    }

    open func getEnvSelected() -> String? {
        let env: String?

        if let envSelected = self.envSelected {
            env = envSelected
        } else {
            env = self.configContainer.endPointSelected[self.endPointSelected]
        }

        return env
    }

    open func getDomainSelected() -> EndPointDomain? {
        guard let envSelected: String = self.getEnvSelected() else {
            fatalError("env selected not found")
        }

        return self.getEndPoint()?.domains[envSelected]
    }
}
