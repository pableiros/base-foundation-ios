//
//  FormPicker.swift
//
//
//  Created by pablo borquez on 23/06/24.
//

import SwiftUI

public struct FormPicker<SelectionValue: Hashable & Identifiable>: View {
    public let title: String
    
    @Binding public var selection: SelectionValue
    
    public let content: [SelectionValue]
    
    public init(_ title: String, selection: Binding<SelectionValue>, content: [SelectionValue]) {
        self.title = title
        self._selection = selection
        self.content = content
    }
    
    public var body: some View {
        Picker(self.title, selection: self.$selection) {
            ForEach(self.content) { option in
                Text(String(describing: option))
            }
        }
    }
}
