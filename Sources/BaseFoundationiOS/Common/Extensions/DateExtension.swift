//
//  File.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

extension Date {
    public static func createFromUTC(yyyyMMddHHmmss: String?) -> Date? {
        guard let yyyyMMddHHmmss = yyyyMMddHHmmss else { return nil }
        
        let dateFormatter = DateFormatter.createyyyyMMddHHmmss()
        dateFormatter.setUTC()
        
        return dateFormatter.date(from: yyyyMMddHHmmss)
    }
    
    public static func createFromddMMyyyy(_ ddMMyyyy: String?) -> Date? {
        guard let ddMMyyyy = ddMMyyyy else { return nil }
        
        let dateFormatter = DateFormatter.createddMMyyyy()
        
        return dateFormatter.date(from: ddMMyyyy)
    }
    
    public func toddMMyyyy(isUTCRequired: Bool = false) -> String {
        let dateFormatter = DateFormatter.createddMMyyyy()
        
        if isUTCRequired {
            dateFormatter.setUTC()
        }
        
        return dateFormatter.string(from: self)
    }
    
    public func toyyyyMMddHHmmss(isUTCRequired: Bool = false) -> String {
        let dateFormatter = DateFormatter.createyyyyMMddHHmmss()
        
        if isUTCRequired {
            dateFormatter.setUTC()
        }
        
        return dateFormatter.string(from: self)
    }
}
