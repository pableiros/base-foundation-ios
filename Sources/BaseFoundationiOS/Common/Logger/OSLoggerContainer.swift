//
//  OSLoggerContainer.swift
//
//
//  Created by pablo borquez on 11/07/23.
//

import Foundation
import OSLog

class OSLoggerContainer: NSObject {
    let subsystem: String
    let category: String
    
    private(set) var logger: Logger
    
    var id: NSString {
        return Self.createId(subsystem: self.subsystem, category: self.category)
    }
    
    init(subsystem: String, category: String) {
        self.subsystem = subsystem
        self.category = category
        
        self.logger = Logger(subsystem: self.subsystem, category: self.category)
    }
    
    static func createId(subsystem: String, category: String) -> NSString {
        return "\(subsystem)-\(category)".toNSString()
    }
}
