//
//  FormState.swift
//
//
//  Created by pablo borquez on 20/12/23.
//

import Foundation

public struct FormState {
    public var isLoading = false
    public var isFormInvalidPresented = false
    public var errorMessage: String = "" {
        didSet {
            if self.errorMessage.isFullEmpty() == false {
                self.isFormInvalidPresented.toggle()
            }
        }
    }
    
    public init(isLoading: Bool = false,
                isFormInvalidPresented: Bool = false,
                errorMessage: String = "") {
        self.isLoading = isLoading
        self.isFormInvalidPresented = isFormInvalidPresented
        self.errorMessage = errorMessage
    }
}
