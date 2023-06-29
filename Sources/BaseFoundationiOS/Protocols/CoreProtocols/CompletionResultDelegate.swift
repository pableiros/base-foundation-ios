//
//  CompletionResultDelegate.swift
//  
//
//  Created by pablo borquez on 28/06/23.
//

import Foundation

public protocol CompletionResultDelegate {
}

extension CompletionResultDelegate {
    public func prepare(continuation: CompletionResultCheckedContinuation) -> CompletionHandler {
       return { success, message, data in
           if success {
               continuation.resume(returning: CompletionResult(data: data))
           } else {
               continuation.throwing(message: message)
           }
       }
   }
}
