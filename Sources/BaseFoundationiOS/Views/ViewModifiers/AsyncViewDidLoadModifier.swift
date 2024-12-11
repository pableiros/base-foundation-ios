//
//  AsyncViewDidLoadModifier.swift
//  BaseFoundationiOS
//
//  Created by pablo borquez on 08/12/24.
//

import SwiftUI

public struct AsyncViewDidLoadModifier: ViewModifier {
    @State private var viewDidLoad = false
    
    private let handler: AsyncHandler?
    
    public init(handler: AsyncHandler? = nil) {
        self.handler = handler
    }
    
    public func body(content: Content) -> some View {
        return content
            .task {
                if self.viewDidLoad == false {
                    self.viewDidLoad = true
                    await self.handler?()
                }
            }
    }
}
