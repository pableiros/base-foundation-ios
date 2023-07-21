//
//  AsyncButton.swift
//  
//
//  Created by pablo borquez on 21/07/23.
//

import SwiftUI

public struct AsyncButton<Label>: View where Label : View {
    let action: AsyncHandler
    let label: () -> Label
    
    public init(action: @escaping AsyncHandler, @ViewBuilder label: @escaping () -> Label) {
        self.action = action
        self.label = label
    }
    
    public var body: some View {
        Button {
            Task {
                await self.action()
            }
        } label: {
            self.label()
        }
    }
}
