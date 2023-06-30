//
//  DateFormatterExtension.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

extension DateFormatter {
    public static func createyyyyMMddHHmmss() -> DateFormatter {
        let dateFormatter = Self.createHourInstance()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter
    }
    
    public static func createHourInstance() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        return dateFormatter
    }
    
    public func setUTC() {
        self.timeZone = TimeZone(abbreviation: "UTC")
    }
}
