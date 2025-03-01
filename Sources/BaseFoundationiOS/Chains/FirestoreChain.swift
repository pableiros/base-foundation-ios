//
//  File.swift
//  BaseFoundationiOS
//
//  Created by pablo borquez on 03/01/25.
//

import Foundation

open class FirestoreChain<FirestoreData> {
    open var nextChain: FirestoreChain?
    
    required public init() { }
    
    public class func createChain<ChainType>(from firestoreChains: [ChainType.Type]) -> ChainType? where ChainType: FirestoreChain<FirestoreData> {
        var firestoreChain: ChainType?

        for typeClass in firestoreChains.reversed() {
            let existingLink: ChainType? = firestoreChain
            firestoreChain = typeClass.init()
            firestoreChain?.nextChain = existingLink
        }

        return firestoreChain
    }
    
    open func handle(resultData: FirestoreData? = nil) async throws -> FirestoreData? {
        var resultData = resultData
        
        await self.handleResult(firestoreData: resultData)
        
        if self.nextChain != nil && resultData == nil {
            resultData = try await self.nextChain?.handle(resultData: resultData)
        }
        
        return resultData
    }
    
    open func logDebug(_ message: String) {
        print(message)
    }
    
    public func breakLink() {
        self.nextChain = nil
    }
    
    // MARK: - private
    
    private func handleResult(firestoreData: FirestoreData?) async {
        if let arrayResult = firestoreData as? Array<Any>,
              arrayResult.isEmpty,
              self.nextChain != nil {            
            self.logDebug("dataArray is empty. Performing delay for 2 seconds")

            await GlobalTask.performDelay(seconds: 0.2)
        } else if self.nextChain != nil {
            self.logDebug("Attempting to break the link")
            self.breakLink()
        }
    }
}
