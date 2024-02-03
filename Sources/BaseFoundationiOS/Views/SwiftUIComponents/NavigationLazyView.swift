//
//  NavigationLazyView.swift
//
//
//  Created by pablo borquez on 03/02/24.
//

import SwiftUI

public struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    
    public init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    public var body: Content {
        self.build()
    }
}
