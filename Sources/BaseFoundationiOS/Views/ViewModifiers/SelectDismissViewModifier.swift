//
//  SelectDismissViewModifier.swift
//  
//
//  Created by pablo borquez on 17/05/24.
//

import SwiftUI

@available(iOS 17, *)
public struct SelectDismissViewModifier<Container: Equatable>: ViewModifier {
    @Environment(\.dismiss) var dismiss

    public let containerSelected: Container?
    public let successHandler: (Container) -> Void
    
    public func body(content: Content) -> some View {
        content
            .onChange(of: self.containerSelected) { _, containerSelected in
            if let containerSelected {
                GlobalTask.performDelay {
                    self.successHandler(containerSelected)
                    self.dismiss()
                }
            }
        }
    }
}
