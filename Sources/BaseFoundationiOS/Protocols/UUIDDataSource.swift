//
//  File.swift
//  
//
//  Created by pablo borquez on 11/05/24.
//

import Foundation

public protocol UUIDDataSource {
    var id: UUID { get set }
}

extension UUIDDataSource {
    public mutating func setId(from dict: [String: Any]) {
        guard let id = dict["id"] as? String, let id = UUID(uuidString: id) else { return }
        
        self.id = id
    }
}
