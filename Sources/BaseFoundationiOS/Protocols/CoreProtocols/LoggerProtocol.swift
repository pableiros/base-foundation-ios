//
//  LoggerProtocol.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation
import OSLog

public protocol LoggerProtocol {
    func debug(_ message: Any?)
    func error(_ message: Any?)
    func error(_ message: Any?, className: String?, method: String?, line: Int?)
    func errorIfNeeded(_ message: Any?)
    func errorIfNeeded(_ message: Any?, className: String?, method: String?, line: Int?)
    func info(_ message: Any?)
    func info(_ message: Any?, className: String?, method: String?, line: Int?)
    func verbose(_ message: Any?)
    func warning(_ message: Any?)
    
    func custom(_ message: Any?, tipoAppLog: TipoAppLog, className: String?, method: String?, line: Int?)

    func prepare()
}

extension LoggerProtocol {
    func printBaseRESTAPI(_ message: Any) {
        let processInfoHelper = BaseProcessInfoHelper()
        let endPointValue: String = processInfoHelper.getValue(fromKey: "ENABLE_RESTAPI_LOG", withDefault: "1")

        if endPointValue == "1" {
            MainLogger.shared?.debug(message)
        }
    }
}
