//
//  NotificationList.swift
//  Conference App
//
//  Created by Felipe on 5/11/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

/// A list of notifications that conforms NSCoding to be able be saved in the UserDefaults
class NotificationList: NSObject{
    
    /// The data structure with the Notifications
    var notifications: [Notification] = []
    
    /**
        Initializes a new Object List capable of being saved in the UserDefaults
     
        - Parameters:
            - notifications: A array containing the notifications
    */
    init(notifications:[Notification]) {
            self.notifications = notifications
    }
    
    required convenience init?(coder decoder: NSCoder){
    
        guard let notifications = decoder.decodeObjectForKey("notifications") as? [Notification] else{
            return nil
        }
        self.init(notifications: notifications)
    }
    
    
    /**
        Appends a notification to the NotificationsList data structure
     
        - Parameter notification: The notification to be appended
    */
    func append(notification: Notification){
        self.notifications.append(notification)
    }
    
    /**
        Returs a Notification object from a specific index in the NotificationsList data structure
        Trying to get a Notification from an invalid index will result in crash
     
        - Parameter index: The index for the required notification on the NotificationsList data structure
     
        - Returns: Returns a notification from the indicated index
    */
    func getAtIndex(index:Int) -> Notification{
        return self.notifications[index]
    }
    
    /**
        The amount of Notifications stored in the NotificationsList data structure
     
        - Returns: The count of the NotificationsList Notifications
    */
    func count() -> Int {
        return self.notifications.count
    }
    
    /**
        Returns and primitive array with the stored Notifications
     
        - Returns: An array with the stored Notifications -> [Notification]
    */
    func getArray() -> [Notification]{
        return self.notifications
    }
    
    /**
        Updates the data from a Notification at a specific array. Overrides the old information.
        Will crash if a invalid index is passed.
     
        - Paramaters:
            - notification: The notification to update.
            - atIndex index: The index where the notification must be saved
    */
    func updateNotification(notification:Notification, atIndex index:Int){
        self.notifications.insert(notification,atIndex: index)
    }
}

//Mark: - NSCoding
extension NotificationList: NSCoding {
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.notifications, forKey: "notifications")
    }
    
}

