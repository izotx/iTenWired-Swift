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
        
        var notificationsArray:[Notification] = []
        
        if let notifications = self.defaults.arrayForKey("Notifications") as? [Notification]{
            notificationsArray = notifications
        }
        notificationsArray.append(notification)
        
        let notificationsData = NSKeyedArchiver.archivedDataWithRootObject(notificationsArray)
        self.defaults.setObject(notificationsData, forKey: "Notification")
        self.defaults.synchronize() // Sync the defaults to update the data
    }
    
    func getAllNotifications() -> [Notification] {
    
        var notificationsArray:[Notification] = []
        
        if let notifications = self.defaults.arrayForKey("Notifications") as? [Notification]{
            notificationsArray = notifications
        }
        return notificationsArray
    }
}