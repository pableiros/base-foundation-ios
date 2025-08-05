//
//  SwiftUIView.swift
//  BaseFoundationiOS
//
//  Created by pablo borquez on 26/07/25.
//

import SwiftUI

public struct ModalViewModifier: ViewModifier {
    public func body(content: Content) -> some View {
        NavigationStack {
            content
        }
        .interactiveDismissDisabled()
    }
}
