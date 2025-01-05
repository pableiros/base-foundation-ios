//
//  FirestoreChainModelDelegate.swift
//  BaseFoundationiOS
//
//  Created by pablo borquez on 05/01/25.
//

import Foundation

public protocol g {
}

extension FirestoreChainModelDelegate {
    public func handleChain<Container, ChainType>(chainType: ChainType.Type) async throws -> [Container] where ChainType: FirestoreChain<[Container]> {
        let chainArray = Array(repeating: chainType, count: 2)
        let chain = FirestoreChain<Container>.createChain(from: chainArray)
        let categorias = try await chain?.handle() ?? [Container]()
        
        return categorias
    }
}
