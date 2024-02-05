//
//  DidSelectViewModifier.swift
//  
//
//  Created by pablo borquez on 05/02/24.
//

import SwiftUI

public struct DidSelectViewModifier<Container: Equatable>: ViewModifier {
    @Environment(\.dismiss) var dismiss
    
    var containerSelected: Container?
    let successHandler: (Container) -> Void
    
    public func body(content: Content) -> some View {
        if #available(iOS 17.0, *) {
            return content
                .onChange(of: self.containerSelected) { _, containerSelected in
                    if let containerSelected {
                        GlobalTask.performDelay {
                            self.successHandler(containerSelected)
                            self.dismiss()
                        }
                    }
                }
        } else {
            return content
        }
    }
}
