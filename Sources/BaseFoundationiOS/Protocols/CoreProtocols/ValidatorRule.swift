//
//  ValidatorRule.swift
//  
//
//  Created by pablo borquez on 21/07/23.
//

import Foundation

public protocol ValidatorRule: AnyObject {
    var message: String? { get set }

    func isValid(value: Any?) -> Bool
}
