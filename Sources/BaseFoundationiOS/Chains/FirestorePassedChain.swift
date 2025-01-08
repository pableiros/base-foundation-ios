//
//  FirestorePassedChain.swift
//  BaseFoundationiOS
//
//  Created by pablo borquez on 05/01/25.
//

import Foundation

open class FirestorePassedChain<FirestoreData, AnyObjectContainer>: FirestoreChain<FirestoreData> {
    public var anyObjectPassed: AnyObjectContainer?
    
    public class func createChain<ChainType>(from firestoreChains: [ChainType.Type], anyObjectPassed: AnyObjectContainer) -> ChainType? where ChainType: FirestorePassedChain<FirestoreData, AnyObjectContainer> {
        
        let chains: ChainType? = FirestoreChain.createChain(from: firestoreChains)
        var currentChain: ChainType? = chains
        
        while currentChain != nil {
            currentChain?.anyObjectPassed = anyObjectPassed
            currentChain = currentChain?.nextChain as? ChainType
        }
        
        return chains
    }
}
