//
//  FetchContentDelegate.swift
//  BaseFoundationiOS
//
//  Created by pablo borquez on 31/12/24.
//

import Foundation

public protocol FetchContentDelegate {
    func performFetchContent() async
}

extension FetchContentDelegate {
    public func fetchContent() {
        Task {
            await self.performFetchContent()
        }
    }
}
