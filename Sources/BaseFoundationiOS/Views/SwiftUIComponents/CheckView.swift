//
//  SwiftUIView.swift
//  
//
//  Created by pablo borquez on 05/02/24.
//

import SwiftUI

public struct CheckView: View {
    let isSelected: Bool
    
    public init(_ isSelected: Bool) {
        self.isSelected = isSelected
    }
    
    public var body: some View {
        Group {
            if self.isSelected {
                Spacer()
                
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
            }
        }
    }
}

#Preview {
    CheckView(true)
}
