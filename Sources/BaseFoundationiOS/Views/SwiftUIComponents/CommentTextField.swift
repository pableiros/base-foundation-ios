//
//  CommentTextField.swift
//
//
//  Created by pablo borquez on 25/06/24.
//

import SwiftUI

public struct CommentTextField: View {
    @Binding public var text: String
    
    public let title: String
    
    public init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    public var body: some View {
        TextField(self.title, text: self.$text, axis: .vertical)
            .autocorrectionDisabled()
            .lineLimit(4...4)
    }
}
