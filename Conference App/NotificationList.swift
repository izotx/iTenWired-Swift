//
//  NotificationList.swift
//  Conference App
//
//  Created by Felipe on 5/11/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

class NotificationList: NSObject, NSCoding{

    var notifications: [Notification] = []

    init(notifications:[Notification]) {
            self.notifications = notifications
    }
    
    required convenience init?(coder decoder: NSCoder){
    
        guard let notifications = decoder.decodeObjectForKey("notifications") as? [Notification] else{
            return nil
        }
        self.init(notifications: notifications)
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.notifications, forKey: "notifications")
    }
    
    func append(notification: Notification){
        self.notifications.append(notification)
    }
    
    func getAtIndex(index:Int) -> Notification{
        return self.notifications[index]
    }
    
    func count() -> Int {
        return self.notifications.count
    }
    
    func getArray() -> [Notification]{
        return self.notifications
    }
    
    func updateNotification(notification:Notification, atIndex:Int){
        self.notifications.insert(notification,atIndex: atIndex)
    }
}