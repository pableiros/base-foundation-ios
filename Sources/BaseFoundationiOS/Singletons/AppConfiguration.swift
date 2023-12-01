//
//  AppConfiguration.swift
//  
//
//  Created by pablo borquez on 28/06/23.
//

import Foundation

final public class AppConfiguration {
    public static let shared: AppConfiguration = AppConfiguration()
    
    public var isOsLoggerRequired = false
    
    public var baseGlobal = BaseGlobal()
    public var baseGlobalSession = BaseGlobalSession()
    public var settingsControllerType: BaseSettingsController.Type = BaseSettingsController.self
    
    let subsystem = "BaseFoundation"
    
    let osLoggerCache = NSCache<NSString, OSLoggerContainer>()
    
    func printBaseRESTAPI(_ message: Any?) {
        if AppConfiguration.shared.isOsLoggerRequired {
            OSLogger.shared.printBaseRESTAPI(message)
        } else {
            MainLogger.shared?.printBaseRESTAPI(message)
        }
    }
}
