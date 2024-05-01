//
//  File.swift
//  
//
//  Created by pablo borquez on 30/04/24.
//

import Foundation

extension StringProtocol {
    public var firstUppercased: String {
        return prefix(1).uppercased() + dropFirst()
    }
}
