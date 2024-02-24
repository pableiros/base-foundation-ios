//
//  JSONManager.swift
//
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

public class JSONManager {
    static let category = String(describing: JSONManager.self)
    
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
    
    
    public func createJsonObject(from file: URL) -> Any? {
        var result: Any?
        
        do {
            let jsonData = try Data(contentsOf: file)
            result = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        } catch {
            OSLogger.standard.error(subsystem: AppConfiguration.shared.subsystem,
                                    category: Self.category,
                                    message: error)
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
    
    public func saveJsonToDocuments(dict: [String: Any], jsonName: String) {
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        let fileUrl = documentDirectoryUrl.appendingPathComponent("\(jsonName).json")
                
        do {
            let data = try JSONSerialization.data(withJSONObject: dict, options: [])
            try data.write(to: fileUrl, options: [])
            
            print("json: \(fileUrl)")
        } catch {
            print(error)
        }
    }
    
    public func getDictFromJsonFile(jsonName: String) -> [String: Any]? {
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let fileUrl = documentDirectoryUrl.appendingPathComponent("\(jsonName).json")

        var dict: [String: Any]?
        
        do {
            let data = try Data(contentsOf: fileUrl, options: [])
            dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error)
        }
        
        return dict
    }
}
