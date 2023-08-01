//
//  JSONManager.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

public class JSONManager {
    public init() { }
    
    public func createJsonObject(fromJsonFileName jsonFileName: String, bundle: Bundle = Bundle.main) -> Any? {
        var result: Any?

        guard let path = bundle.path(forResource: jsonFileName, ofType: "json") else {
            print("\(jsonFileName).json not found")
            return result
        }

        if let jsonData: NSData = try? NSData(contentsOfFile: path, options: .dataReadingMapped) {
            result = try? JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers)
        }

        return result
    }

    public func createDictionary(from jsonString: String) -> [String: AnyObject]? {
        var result: [String: AnyObject]?

        if let data: Data = jsonString.data(using: .utf8) {
            result = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
        }

        return result
    }
}
