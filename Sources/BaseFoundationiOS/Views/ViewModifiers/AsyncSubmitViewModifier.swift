//
//  AsyncSubmitViewModifier.swift
//  
//
//  Created by pablo borquez on 21/07/23.
//

import SwiftUI

public struct AsyncSubmitViewModifier: ViewModifier {
    let action: AsyncHandler

    public func body(content: Content) -> some View {
        content.onSubmit {
            Task {
                await self.action()
            }
        }
    }
}
