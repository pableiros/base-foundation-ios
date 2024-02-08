//
//  BaseSettingsController.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

open class BaseSettingsController: ConfigController {
    enum BaseKey: String {
        case timeOutIntervalForRequest = "Time out interval for request"
        case httpMaximumConnectionsPerHost = "HTTP Maximum Connections Per Host"
        case printRawResponse = "Print raw response"
    }
    
    public func getSettingNumber(for keyValue: String) -> NSNumber {
        let settings: NSDictionary = self.getSettings()
        return settings[keyValue] as! NSNumber
    }
    
    public func getSettingBool(for keyValue: String) -> Bool {
        let settings: NSDictionary = self.getSettings()
        return settings[keyValue] as! Bool
    }
        
    public func getSettings() -> NSDictionary {
        return self.object(forKey: "Settings")
    }
}
