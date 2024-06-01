//
//  BaseForm.swift
//  
//
//  Created by pablo borquez on 01/06/24.
//

import SwiftUI

public struct BaseForm<Content> : View where Content : View {
    public var content: Content
    
    @inlinable public init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        Form {
            self.content
        }
        .scrollDismissesKeyboard(.interactively)
    }
}
