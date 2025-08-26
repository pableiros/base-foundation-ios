//
//  KeyboardToolbarModifier.swift
//  BaseFoundationiOS
//
//  Created by pablo borquez on 25/08/25.
//

import SwiftUI

public struct KeyboardToolbarModifier<FocusType: Hashable>: ViewModifier {
    @StateObject private var keyboardObserver = KeyboardObserver()
    @FocusState.Binding var focus: FocusType?
    
    let buttonTitle: String
    
    public func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .bottom) {
                if self.keyboardObserver.isVisible {
                    HStack {
                        Spacer()
                        Button(self.buttonTitle) {
                            self.focus = nil
                        }
                        .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(.ultraThinMaterial)
                    .shadow(radius: 2)
                    .transition(
                        .move(edge: .bottom)
                        .combined(with: .opacity)
                    )
                }
            }
    }
}
