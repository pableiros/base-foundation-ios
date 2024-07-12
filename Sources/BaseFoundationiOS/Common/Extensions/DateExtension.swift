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
    
    public func toyyyyMMdd(isUTCRequired: Bool = false) -> String {
        let dateFormatter = DateFormatter.createyyyyMMdd()
        
        if isUTCRequired {
            dateFormatter.setUTC()
        }
        
        return dateFormatter.string(from: self)
    }
    
    public func getDay() -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        
        return formatter.string(from: self).toInt()
    }
    
    public func isEqual(to date: Date,
                        toGranularity component: Calendar.Component,
                        in calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }
    
    public func isInSameYear(as date: Date) -> Bool {
        return self.isEqual(to: date, toGranularity: .year)
    }
    
    public func isInSameMonth(as date: Date) -> Bool {
        return self.isEqual(to: date, toGranularity: .month)
    }
    
    public func add(component: Calendar.Component, value: Int) -> Date {
        return Calendar.current.date(byAdding: component, value: value, to: self)!
    }
    
    public func getMonthName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMM")
        
        return dateFormatter.string(from: self)
    }
}
