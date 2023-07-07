//
//  AsyncAwaitHandler.swift
//  
//
//  Created by pablo borquez on 07/07/23.
//

import Foundation

public typealias AsyncAwaitHandler = @Sendable () async throws -> Void
