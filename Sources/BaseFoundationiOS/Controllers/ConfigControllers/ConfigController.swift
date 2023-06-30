//
//  ConfigController.swift
//  
//
//  Created by pablo borquez on 28/06/23.
//

import Foundation

open class ConfigController {
    private let documentName: String = "Config"
    private let documentExtension: String = "plist"
    
    required public init() { }

    open func object(forKey key: String) -> NSDictionary {
        let result: NSDictionary!

        if let cachedVersion: NSDictionary = AppConfiguration.shared.baseGlobal.configCache.object(forKey: key as NSString) {
            result = cachedVersion
        } else {
            let configContent: NSDictionary = self.getConfigContent()
            result = configContent.object(forKey: key) as? NSDictionary

            AppConfiguration.shared.baseGlobal.configCache.setObject(result, forKey: key as NSString)
        }

        return result
    }

    open func getConfigContent() -> NSDictionary {
        let pListUrl: URL = Bundle.main.url(forResource: self.documentName, withExtension: self.documentExtension)!
        let plistDocument: NSDictionary = NSDictionary(contentsOf: pListUrl)!

        return plistDocument
    }
}
