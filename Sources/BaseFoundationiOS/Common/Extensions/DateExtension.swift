//
//  File.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

extension Date {
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
