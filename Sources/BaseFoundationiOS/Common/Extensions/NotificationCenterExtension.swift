//
//  File.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

extension NotificationCenter {
    public static func addNotificationForNameOnMainQueue(_ notificationName: String, usingBlock: @escaping (Notification) -> Void) -> NSObjectProtocol {
        let center: NotificationCenter = NotificationCenter.default
        let queue: OperationQueue = OperationQueue.main
        return center.addObserver(forName: NSNotification.Name(rawValue: notificationName),
                                  object: nil,
                                  queue: queue,
                                  using: usingBlock)
    }
    
    public static func removeObserverNotification(_ observer: AnyObject) {
        let center: NotificationCenter = NotificationCenter.default
        center.removeObserver(observer)
    }
    
    public static func setObserver(_ observer: AnyObject, selector: Selector, notificationName: NotificationNameDelegate, object: AnyObject?) {
        setObserver(observer, selector: selector, notificationName: notificationName.toNotificationName(), object: object)
    }
    
    public static func setObserver(_ observer: AnyObject, selector: Selector, name: String, object: AnyObject? = nil) {
        let notificationName = Notification.Name(rawValue: name)
        NotificationCenter.setObserver(observer, selector: selector, notificationName: notificationName, object: object)
    }
    
    public static func setObserver(_ observer: AnyObject, selector: Selector, notificationName: NSNotification.Name, object: AnyObject?) {
        NotificationCenter.default.removeObserver(observer, name: notificationName, object: object)
        NotificationCenter.default.addObserver(observer, selector: selector, name: notificationName, object: object)
    }
    
    public static func postNotification(byName name: String, object: Any? = nil) {
        NotificationCenter.default.post(name: NSNotification.Name(name), object: object)
    }
    
    public static func remove(observer: NSObjectProtocol?, name: NotificationNameDelegate) {
        guard let observer = observer else { return }
        
        NotificationCenter.default.removeObserver(observer,
                                                  name: name.toNotificationName(),
                                                  object: nil)
    }
}
