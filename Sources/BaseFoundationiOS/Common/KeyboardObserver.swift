//
//  KeyboardObserver.swift
//  BaseFoundationiOS
//
//  Created by pablo borquez on 22/08/25.
//

import UIKit

public final class KeyboardObserver: ObservableObject {
    @Published public var isVisible = false

    private var willShow: NSObjectProtocol?
    private var willHide: NSObjectProtocol?

    public init() {
        self.initWillShow()
        self.initWillHide()
    }

    deinit {
        if let willShow {
            NotificationCenter.default.removeObserver(willShow)
        }
        
        if let willHide {
            NotificationCenter.default.removeObserver(willHide)
        }
    }
    
    // MARK: - private
    
    private func initWillShow() {
        self.willShow = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,
                                                               object: nil,
                                                               queue: .main) { [weak self] _ in
            self?.isVisible = true
        }
    }
    
    private func initWillHide() {
        self.willHide = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                                               object: nil,
                                                               queue: .main) { [weak self] _ in
            self?.isVisible = false
        }
    }
}
