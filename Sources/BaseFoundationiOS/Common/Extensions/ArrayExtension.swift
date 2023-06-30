//
//  ArrayExtension.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

extension Array {
    public func toJSONText() -> String {
        var jsonText: String = ""

        if let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted]) {
            jsonText = String(data: theJSONData, encoding: .utf8)!
        }

        return jsonText.replacingOccurrences(of: #"\/"#, with: "/")
    }
}
