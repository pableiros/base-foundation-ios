//
//  CoreLogger.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

open class CoreLogger: LoggerProtocol {
    private let isDebugEnabled: Bool
    private let isErrorEnabled: Bool
    private let isInfoEnabled: Bool
    private let isVerboseEnabled: Bool
    private let isWarningEnabled: Bool
    
    public init(isDebugEnabled: Bool = true,
         isErrorEnabled: Bool = true,
         isInfoEnabled: Bool = true,
         isVerboseEnabled: Bool = true,
         isWarningEnabled: Bool = true) {
        self.isDebugEnabled = isDebugEnabled
        self.isErrorEnabled = isErrorEnabled
        self.isInfoEnabled = isInfoEnabled
        self.isVerboseEnabled = isVerboseEnabled
        self.isWarningEnabled = isWarningEnabled
    }
    
    open func debug(_ message: Any?) {
        if self.isDebugEnabled {
            self.printToLog(message: message, type: "DEBUG")
        }
    }
    
    open func error(_ message: Any?) {
        if self.isErrorEnabled {
            self.printToLog(message: message, type: "ERROR")
        }
    }
    
    open func error(_ message: Any?, className: String?, method: String?, line: Int?) {
        self.error(message)
        
        self.performLogRequest(tipoAppLog: .error,
                               message: message,
                               className: className,
                               method: method,
                               line: line)
    }
    
    open func errorIfNeeded(_ message: Any?) {
        if let message = message {
            self.error(message)
        }
    }
    
    open func errorIfNeeded(_ message: Any?, className: String?, method: String?, line: Int?) {
        if let message = message {
            self.error(message, className: className, method: method, line: line)
        }
    }
    
    open func info(_ message: Any?) {
        if self.isInfoEnabled {
            self.printToLog(message: message, type: "INFO")
        }
    }
    
    open func info(_ message: Any?, className: String?, method: String?, line: Int?) {
        self.info(message)
        
        self.performLogRequest(tipoAppLog: .info,
                               message: message,
                               className: className,
                               method: method,
                               line: line)
    }
    
    open func custom(_ message: Any?, tipoAppLog: TipoAppLog, className: String?, method: String?, line: Int?) {
        self.info(message)

        self.performLogRequest(tipoAppLog: tipoAppLog,
                               message: message,
                               className: className,
                               method: method,
                               line: line)
    }
    
    open func verbose(_ message: Any?) {
        if self.isVerboseEnabled {
            self.printToLog(message: message, type: "VERBOSE")
        }
    }
    
    open func warning(_ message: Any?) {
        if self.isWarningEnabled {
            self.printToLog(message: message, type: "WARNING")
        }
    }
    
    open func prepare() {
    }
    
    open func registerLog(appLogContainer: AppLogContainer) {
        //  Example
        //        let appLogController = AppLogController()
        //        appLogController.create(appLogContainer: appLogContainer)
    }
    
    // MARK: - private
    
    private func printToLog(message: Any?, type: String) {
        print("\(self.getDate()) [\(type)] \(message ?? "nil")")
    }
    
    private func getDate() -> String {
        return Date().toyyyyMMddHHmmss()
    }
    
    private func performLogRequest(tipoAppLog: TipoAppLog,
                                   message: Any?,
                                   className: String?,
                                   method: String?,
                                   line: Int?) {
        let appLogContainer = AppLogContainer(tipoAppLog: tipoAppLog,
                                              className: className,
                                              method: method,
                                              line: line,
                                              message: message)
        
        self.registerLog(appLogContainer: appLogContainer)
    }
}
