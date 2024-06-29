//
//  NavigationStackViewModifier.swift
//  
//
//  Created by pablo borquez on 12/09/23.
//

import SwiftUI

public struct NavigationStackViewModifier: ViewModifier {
    public func body(content: Content) -> some View {
        return NavigationStack {
            content
        }
    }
}
