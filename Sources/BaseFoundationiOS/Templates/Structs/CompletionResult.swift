//
//  CompletionResult.swift
//  
//
//  Created by pablo borquez on 28/06/23.
//

import Foundation

public struct CompletionResult {
    public let data: Any?
        
    public func convertData<T>() throws -> T {
        guard let dataConverted = data as? T else {
            throw BaseLocalizables.internalServerError
        }

        return dataConverted
    }
}

