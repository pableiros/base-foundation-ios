//
//  MaxFrameViewModifier.swift
//  
//
//  Created by pablo borquez on 17/08/23.
//

import SwiftUI

public struct MaxFrameViewModifier: ViewModifier {
    let alignment: Alignment
    
    public func body(content: Content) -> some View {
        return content
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: self.alignment)
    }
}
