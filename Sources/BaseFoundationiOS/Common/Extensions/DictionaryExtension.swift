//
//  File.swift
//  
//
//  Created by pablo borquez on 28/06/23.
//

import Foundation

extension Dictionary {
    public mutating func update(_ other: Dictionary) {
        for (key, value) in other {
            self.updateValue(value, forKey: key)
        }
    }
}
