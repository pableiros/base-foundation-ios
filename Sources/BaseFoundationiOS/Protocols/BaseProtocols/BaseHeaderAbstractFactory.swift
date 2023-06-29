//
//  BaseHeaderAbstractFactory.swift
//  
//
//  Created by pablo borquez on 28/06/23.
//

import Foundation

public protocol BaseHeaderAbstractFactory {
    func createExtraHeadersForRequest() -> [String: String]?
}
