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
    let successHandler: ((Container) -> Void)?
    
    public func body(content: Content) -> some View {
        if #available(iOS 17.0, *) {
            return content
                .if(self.successHandler != nil) {
                    $0.onChange(of: self.containerSelected) { _, containerSelected in
                        self.onChange(containerSelected: containerSelected)
                    }
                }
        } else {
            return content
        }
    }
    
    // MARK: - private
    
    private func onChange(containerSelected: Container?) {
        guard let containerSelected, let successHandler else { return  }
        
        GlobalTask.performDelay {
            successHandler(containerSelected)
            self.dismiss()
        }
    }
}
