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
    
    public class func createChain<Generic>(from firestoreChains: [FirestoreChain<Generic>.Type]) -> FirestoreChain<Generic>? {
        var firestoreChain: FirestoreChain<Generic>?

        for typeClass in firestoreChains.reversed() {
            let existingLink: FirestoreChain<Generic>? = firestoreChain
            firestoreChain = typeClass.init()
            firestoreChain?.nextChain = existingLink
        }

        return firestoreChain
    }
    
    open func handle() async throws -> FirestoreData? {
        var firestoreData: FirestoreData?
        
        if self.nextChain != nil {
            firestoreData = try await self.nextChain?.handle()
            
            await self.handleResult(firestoreData: firestoreData)
        }
        
        return firestoreData
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

            await GlobalTask.performDelay(seconds: 2)
        } else {
            self.breakLink()
        }
    }
}
