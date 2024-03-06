//
//  DoubleExtension.swift
//
//
//  Created by pablo borquez on 22/07/23.
//

import Foundation

extension Double {
    public func toString(addZero: Bool = false) -> String {
        var stringValue: String
        
        if let intValue = Int(exactly: self) {
            stringValue = String(intValue)
        } else {
            stringValue = String(self)
        }
        
        if addZero, self < 10 {
            stringValue = "0\(stringValue)"
        }
        
        return stringValue
    }
    
    public func toCurrency(currencyCode: String = "MXN",
                           numberStyle: NumberFormatter.Style = .currency,
                           decimals: Int = 2) -> String {
        let finalDoubleString = String(format: "%.\(decimals)f", self)
        guard let finalDouble = Double(finalDoubleString) else { return "-" }
        let numberToFormat = finalDouble as NSNumber
        let formatter = NumberFormatter()
        
        switch currencyCode {
        case "EUR":
            formatter.locale = Locale(identifier: "en_EN")
            formatter.currencyCode = currencyCode
        case "YEN":
            formatter.locale = Locale(identifier: "jp_JP")
        default:
            formatter.locale = Locale(identifier: "es_MX")
        }
        
        formatter.numberStyle = numberStyle
        
        if numberStyle != .spellOut {
            formatter.negativePrefix = "\(formatter.negativePrefix!) "
            formatter.positivePrefix = "\(formatter.positivePrefix!) "
        }
        
        let stringFormatted = formatter.string(from: numberToFormat)
        
        return stringFormatted!
    }
}
