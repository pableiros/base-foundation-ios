//
//  DoubleExtension.swift
//  
//
//  Created by pablo borquez on 22/07/23.
//

import Foundation

extension Double {
    public func toString() -> String {
        let stringValue: String

        if let intValue = Int(exactly: self) {
            stringValue = String(intValue)
        } else {
            stringValue = String(self)
        }

        return stringValue
    }
}
