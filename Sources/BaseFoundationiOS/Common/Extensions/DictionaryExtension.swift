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

extension Dictionary where Key == String {
    public func get(for key: String) -> String {
        return self[key] as? String ?? ""
    }
    
    public func get(for key: String) -> Bool {
        return self[key] as? Bool ?? false
    }
    
    public func get(for key: String) -> Int {
        var value: Int = 0

        if let dictValue = self[key] as? Int {
            value = dictValue
        } else if let dictValue = self[key] as? String, let dictIntValue: Int = Int(dictValue) {
            value = dictIntValue
        }

        return value
    }

    public func get(for key: String) -> Double {
        var value: Double = 0

        if let dictValue = self[key] as? Double {
            value = dictValue
        } else if let dictValue = self[key] as? String, let dictIntValue: Double = Double(dictValue) {
            value = dictIntValue
        }

        return value
    }
    
    public func getDictArray(for key: String) -> [[String: Any]] {
        return self[key] as? [[String: Any]] ?? [[String: Any]]()
    }
}
