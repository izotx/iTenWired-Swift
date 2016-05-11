//
 //  NotificationController.swift
//  Conference App
//
//  Created by Felipe on 5/10/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation


class NotificationController{

    let defaults = NSUserDefaults.standardUserDefaults()
    
    // Adds a notification to the notifications array in the UserDefaults
    func addNotification(notification:Notification){
       
        let notificationsArray = self.getAllNotifications()
        notificationsArray.append(notification)
        
        let notificationsData = NSKeyedArchiver.archivedDataWithRootObject(notificationsArray)
        self.defaults.setObject(notificationsData, forKey: "Notifications")
        self.defaults.synchronize() // Sync the defaults to update the data
    }
    
    func getAllNotifications() -> NotificationList {
        let arr = [Notification]()
        var notificationsArray = NotificationList(notifications: arr)
        
        if let data = self.defaults.objectForKey("Notifications") as? NSData{
            if let notifications = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? NotificationList {
                notificationsArray = notifications
            }
        }
        return notificationsArray
    }
}