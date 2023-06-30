//
//  ErrorExtension.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

extension Error {
    public var errorCode: Int? {
        return (self as NSError).code
    }
    
    /// Error que se produce cuando se intenta agregar un archivo que no es imagen mediante `drag & drop`.
    public func isArchivoDraggedError() -> Bool {
        return self.errorCode == -1000
    }
    
    public func toString() -> String {
        let bannerMessage: String
        
        if let errorMessage = self as? String {
            bannerMessage = errorMessage
        } else {
            bannerMessage = self.localizedDescription
        }
        
        return bannerMessage
    }
}
