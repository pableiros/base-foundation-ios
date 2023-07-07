//
//  File.swift
//  
//
//  Created by pablo borquez on 07/07/23.
//

import Foundation

public struct ConfigContainer {
    public var endPointSelected: [String: String] = [:]
    public var endPoints: [String: EndPoint] = [:]

    public init() {
        let configController: ConfigController = ConfigController()
        let content: [String: Any] = configController.getConfigContent() as! [String: Any]

        self.setEndPointsSelected(content: content)
        self.setEndPoints(content: content)
    }
    
    // MARK: - private

    private mutating func setEndPointsSelected(content: [String: Any]) {
        guard let endPointsSelected: [String: String] = content[ConfigKey.endPointSelectedKey] as? [String: String] else {
            fatalError("End Points Selected not found in Config.plist")
        }

        self.endPointSelected = endPointsSelected
    }

    private mutating func setEndPoints(content: [String: Any]) {
        guard let endPoints: [String: Any] = content[ConfigKey.endPoints] as? [String: Any] else {
            fatalError("End Points not found in Config.plist")
        }

        self.endPoints = endPoints.mapValues({ (endPointDict) -> EndPoint in
            EndPoint.createFromDictionary(dict: endPointDict as! [String: Any])
        })
    }
}
