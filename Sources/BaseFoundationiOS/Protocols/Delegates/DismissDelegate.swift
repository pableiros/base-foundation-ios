//
//  DismissDelegate.swift
//
//
//  Created by pablo borquez on 28/05/24.
//

import SwiftUI

public protocol DismissDelegate {
    var dismiss: DismissAction { get }
}

extension DismissDelegate {
    public func performDismiss() {
        GlobalTask.performDelay {
            self.dismiss()
        }
    }
}
