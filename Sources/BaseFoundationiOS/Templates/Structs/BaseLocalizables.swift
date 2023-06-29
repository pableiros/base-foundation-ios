//
//  BaseLocalizables.swift
//  
//
//  Created by pablo borquez on 29/06/23.
//

import Foundation

public struct BaseLocalizables {
    public static var internalServerError: String {
        return "internalServerError".translateCoreLocalizable()
    }
    
    public static var serverUnreachable: String {
        return "serverUnreachable".translateCoreLocalizable()
    }
}
