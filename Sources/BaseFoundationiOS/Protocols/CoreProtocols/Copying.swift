//
//  File.swift
//  
//
//  Created by pablo borquez on 28/07/23.
//

import Foundation

public protocol Copying {
    init(original: Self)
}

extension Copying {
    public func copy() -> Self {
        return Self.init(original: self)
    }
}
