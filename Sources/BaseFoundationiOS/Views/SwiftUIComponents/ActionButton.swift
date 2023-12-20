//
//  ActionButton.swift
//
//
//  Created by pablo borquez on 19/12/23.
//

import SwiftUI

public struct ActionButton: View {
    public var title: String
    
    @Binding public var isLoading: Bool
    
    public let actionHandler: SimpleHandler
    
    public init(title: String,
                isLoading: Binding<Bool>,
                actionHandler: @escaping SimpleHandler) {
        self.title = title
        self._isLoading = isLoading
        self.actionHandler = actionHandler
    }
    
    public var body: some View {
        Group {
            if self.isLoading {
                Button {
                    
                } label: {
                    ProgressView()
                        .controlSize(.mini)
                        .frame(width: 50)
                    
                }
            } else {
                Button {
                    
                } label: {
                    Text(self.title)
                }
            }
        }
        .buttonStyle(.borderedProminent)
        .disabled(self.isLoading)
    }
}
