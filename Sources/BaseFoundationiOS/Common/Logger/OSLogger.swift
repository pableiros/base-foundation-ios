//
//  OSLogger.swift
//
//
//  Created by pablo borquez on 10/07/23.
//

import Foundation
import OSLog

open class OSLogger {
    public static let shared = OSLogger()
    
    private var isDebugEnabled = true
    private var isErrorDebugEnabled = true

    private var loggers = [OSLoggerContainer]()
    
    open func debug(subsystem: String, category: String, message: Any?) {
        guard self.isDebugEnabled else { return }
        
        let logger = self.getLogger(subsystem: subsystem, category: category)
        logger.debug("\(self.getPrintable(message: message))")
    }
    
    open func error(subsystem: String, category: String, message: Any?) {
        guard self.isErrorDebugEnabled else { return }
        
        let logger = self.getLogger(subsystem: subsystem, category: category)
        logger.error("\(self.getPrintable(message: message))")
    }
    
    func printBaseRESTAPI(_ message: Any?) {
        let processInfoHelper = BaseProcessInfoHelper()
        let endPointValue: String = processInfoHelper.getValue(fromKey: "ENABLE_RESTAPI_LOG", withDefault: "1")

        if endPointValue == "1" {
            self.debug(subsystem: AppConfiguration.shared.subsystem,
                       category: BaseRESTAPIModel.category,
                       message: message)
        }
    }
    
    // MARK: - private
    
    private func getLogger(subsystem: String, category: String) -> Logger {
        let logger: Logger
        let id = OSLoggerContainer.createId(subsystem: subsystem, category: category)
        
        var osLoggerContainer: OSLoggerContainer?
        
        if let osLoggerContainer = AppConfiguration.shared.osLoggerCache.object(forKey: id) {
            logger = osLoggerContainer.logger
        } else if let osLogger = self.loggers.first(where: { osLoggerContainer in
            return osLoggerContainer.subsystem == subsystem && osLoggerContainer.category == category
        }) {
            logger = osLogger.logger
            osLoggerContainer = osLogger
        } else {
            let osLogger = OSLoggerContainer(subsystem: subsystem, category: category)
            logger = osLogger.logger
            
            self.loggers.append(osLogger)
            
            osLoggerContainer = osLogger
        }
        
        if let osLoggerContainer {
            AppConfiguration.shared.osLoggerCache.setObject(osLoggerContainer, forKey: id)
        }
        
        return logger
    }
    
    private func getPrintable(message: Any?) -> String {
        return "\(message ?? "nil")"
    }
}
