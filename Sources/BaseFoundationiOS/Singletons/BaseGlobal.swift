//
//  BaseGlobal.swift
//  
//
//  Created by pablo borquez on 28/06/23.
//

import Foundation

open class BaseGlobal {
    public lazy var configCache = NSCache<NSString, NSDictionary>()

    public init() { }
}
