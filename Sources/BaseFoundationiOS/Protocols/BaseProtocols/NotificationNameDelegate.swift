//
//  NotificationNameDelegate.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

public protocol NotificationNameDelegate: RawValueDataSource {
}

extension NotificationNameDelegate {
    public func toNotificationName() -> Notification.Name {
        return Notification.Name(self.rawValue)
    }
    
    public func toNotification() -> Notification {
        Notification(name: self.toNotificationName(),
                     object: nil,
                     userInfo: nil)
    }
}
