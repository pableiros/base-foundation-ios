//
//  KeyChainKey.swift
//
//
//  Created by pablo borquez on 12/07/23.
//

import Foundation

struct KeyChainKey {
    static let token = "token"
    
    static func generatePasswordKey(userId: String) -> String {
        return "user-password-\(userId)"
    }
}
