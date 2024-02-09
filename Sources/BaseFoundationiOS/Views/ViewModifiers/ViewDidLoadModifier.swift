//
//  ViewDidLoadModifier.swift
//
//
//  Created by pablo borquez on 08/02/24.
//

import SwiftUI

public struct ViewDidLoadModifier: ViewModifier {
    @State private var viewDidLoad = false
    
    private let handler: SimpleHandler?
    
    public init(handler: SimpleHandler? = nil) {
        self.handler = handler
    }
    
    public func body(content: Content) -> some View {
        return content
            .onAppear {
                if self.viewDidLoad == false {
                    self.viewDidLoad = true
                    self.handler?()
                }
            }
    }
}
