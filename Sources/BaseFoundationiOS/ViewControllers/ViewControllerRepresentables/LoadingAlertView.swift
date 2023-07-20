//
//  LoadingAlertView.swift
//
//
//  Created by pablo borquez on 05/07/23.
//

import SwiftUI

#if os(iOS) || os(macOS)
public struct LoadingAlertView: UIViewControllerRepresentable {
    @Binding public var isLoading: Bool

    public var loadingMessage: String
    
    public init(isLoading: Binding<Bool>, loadingMessage: String) {
        self._isLoading = isLoading
        self.loadingMessage = loadingMessage
    }
    
    @MainActor public func makeUIViewController(context: Context) -> UIViewController {
        return UIViewController()
    }
    
    @MainActor public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if self.isLoading {
            let loadingAlertController = LoadingAlertController.create(loadingMessage: self.loadingMessage)
            context.coordinator.loadingAlertController = loadingAlertController
            
            DispatchQueue.main.async {
                uiViewController.present(loadingAlertController, animated: true)
            }
           
        } else {
            context.coordinator.loadingAlertController?.dismiss(animated: true, completion: nil)
            context.coordinator.loadingAlertController = nil
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    public class Coordinator: NSObject {
        var loadingAlertController: LoadingAlertController?
        
        var loadingAlertControllerView: LoadingAlertView
        
        init(_ loadingAlertControllerView: LoadingAlertView) {
            self.loadingAlertControllerView = loadingAlertControllerView
        }
    }
}
#endif
