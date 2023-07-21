//
//  AlertViewModifier.swift
//  
//
//  Created by pablo borquez on 21/07/23.
//

import SwiftUI

public struct AlertViewModifier: ViewModifier {
    @Binding var isPresented: Bool

    var title: String
    var message: String
    var isCancelRequired = false
    var okHandler: SimpleHandler? = nil
        
    public func body(content: Content) -> some View {
        content.alert(self.title, isPresented: self.$isPresented) {
            Button(role: .none) {
                self.okHandler?()
            } label: {
                Text("Aceptar")
            }

            if self.isCancelRequired {
                Button(role: .cancel) {
                } label: {
                    Text("Cancelar")
                }

            }
        } message: {
            Text(self.message)
        }
    }
}
