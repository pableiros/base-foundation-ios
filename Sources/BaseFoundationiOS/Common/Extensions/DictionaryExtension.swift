//
//  DictionaryExtension.swift
//  
//
//  Created by pablo borquez on 28/06/23.
//

import Foundation

extension Dictionary {
    public func toJSONText() -> String {
        var jsonText: String = ""

        if let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted]) {
            jsonText = String(data: theJSONData, encoding: .utf8)!
        }

        return jsonText.replacingOccurrences(of: #"\/"#, with: "/")
    }
    
    public mutating func update(_ other: Dictionary) {
        for (key, value) in other {
            self.updateValue(value, forKey: key)
        }
    }
}
