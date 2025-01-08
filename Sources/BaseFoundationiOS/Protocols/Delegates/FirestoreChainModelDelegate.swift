//
//  FirestoreChainModelDelegate.swift
//  BaseFoundationiOS
//
//  Created by pablo borquez on 05/01/25.
//

import Foundation

public protocol FirestoreChainModelDelegate {
}

extension FirestoreChainModelDelegate {
    public func handleChain<Container, ChainType>(chainType: ChainType.Type) async throws -> [Container] where ChainType: FirestoreChain<[Container]> {
        let chainArray = self.genereteChainArray(chainType: chainType)
        let chain = FirestoreChain.createChain(from: chainArray)
        let result = try await chain?.handle() ?? [Container]()
        
        return result
    }
    
    public func handleChain<Container, ChainType, AnyObjectContainer>(chainType: ChainType.Type, anyObjectPassed: AnyObjectContainer) async throws -> [Container] where ChainType: FirestorePassedChain<[Container], AnyObjectContainer> {
        let chainArray = self.genereteChainArray(chainType: chainType)
        let chain = FirestorePassedChain.createChain(from: chainArray, anyObjectPassed: anyObjectPassed)
        let result = try await chain?.handle() ?? [Container]()
        
        return result
    }
    
    private func genereteChainArray<ChainType>(chainType: ChainType.Type) -> [ChainType.Type] {
        return Array(repeating: chainType, count: 2)
    }
}
