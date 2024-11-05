//
//  File.swift
//  
//
//  Created by pablo borquez on 20/01/24.
//

import Foundation

public class GlobalTask {
    public static func performDelay(seconds: Double = 0.1, handler: @escaping SimpleHandler) {
        Task {
            try await Task.sleep(for: .seconds(seconds))
            
            await MainActor.run {
                handler()
            }
        }
    }
    
    public static func performDelay(seconds: Double = 0.1) async {
        await withCheckedContinuation { continuation in
            Self.performDelay {
                continuation.resume()
            }
        }
    }
}
