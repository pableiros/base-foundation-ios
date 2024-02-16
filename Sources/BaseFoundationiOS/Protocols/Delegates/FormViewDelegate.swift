//
//  FormViewDelegate.swift
//
//
//  Created by pablo borquez on 16/02/24.
//

import SwiftUI

public protocol FormViewDelegate: FormViewValidatorDelegate {
    associatedtype Container
    
    var dismiss: DismissAction { get }
    
    var successHandler: (Container) -> Void { get set }
    
    var editContainer: Container? { get set }
}

extension FormViewDelegate {
    public var isEdit: Bool {
        return self.editContainer != nil
    }
    
    public var editContainer: Container? {
        get {
            return nil
        }
        set {
        }
    }
}
