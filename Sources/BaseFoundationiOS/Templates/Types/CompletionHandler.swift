//
//  CompletionHandler.swift
//  
//
//  Created by pablo borquez on 29/06/23.
//

import Foundation

public typealias CompletionHandler = (_ success: Bool, _ message: String?, _ data: Any?) -> Void

public func createCompletionContinuation(continuation: CheckedVoidContinuation) -> CompletionHandler {
    return { success, message, _ in
        if success {
            continuation.resume()
        } else {
            continuation.throwing(message: message)
        }
    }
}
