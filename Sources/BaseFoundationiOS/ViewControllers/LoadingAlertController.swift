//
//  LoadingAlertController.swift
//  
//
//  Created by pablo borquez on 28/06/23.
//

#if canImport(UIKit)

import UIKit

public class LoadingAlertController: UIAlertController {
    public static func create(loadingMessage: String) -> LoadingAlertController {
        let loadingAlertController: LoadingAlertController = LoadingAlertController(title: loadingMessage, message: nil, preferredStyle: .alert)
        loadingAlertController.setActivityIndicator()
        loadingAlertController.setHeight()

        return loadingAlertController
    }
    
    // MARK: - private

    private func setActivityIndicator() {
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(activityIndicator)

        let xConstraint: NSLayoutConstraint = NSLayoutConstraint(item: activityIndicator,
                                                                 attribute: .centerX,
                                                                 relatedBy: .equal,
                                                                 toItem: self.view,
                                                                 attribute: .centerX,
                                                                 multiplier: 1,
                                                                 constant: 0)
        let yConstraint: NSLayoutConstraint = NSLayoutConstraint(item: activityIndicator,
                                                                 attribute: .centerY,
                                                                 relatedBy: .equal,
                                                                 toItem: self.view,
                                                                 attribute: .centerY,
                                                                 multiplier: 1.4,
                                                                 constant: 0)

        NSLayoutConstraint.activate([xConstraint, yConstraint])
        activityIndicator.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
    }

    private func setHeight() {
        let height: NSLayoutConstraint = NSLayoutConstraint(item: self.view!,
                                                            attribute: NSLayoutConstraint.Attribute.height,
                                                            relatedBy: NSLayoutConstraint.Relation.equal,
                                                            toItem: nil,
                                                            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                            multiplier: 1,
                                                            constant: 80)
        self.view.addConstraint(height)
    }
}
#endif
