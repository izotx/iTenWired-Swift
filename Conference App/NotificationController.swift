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
       
        var notificationsArray = self.getAllNotifications()
        notificationsArray.append(notification)
        
        let notificationsData = NSKeyedArchiver.archivedDataWithRootObject(NotificationList(notifications: notificationsArray))
        
        self.defaults.setObject(notificationsData, forKey: "Notifications")
        self.defaults.synchronize() // Sync the defaults to update the data
    }
    
    func deleteNotification(notification:Notification){
        
        var notificationsArray = self.getAllNotifications()
        
        
        for var index in Range(start: 0,end: notificationsArray.count) {
            if notificationsArray[index].date.isEqualToDate(notification.date){
                print(notificationsArray[index].date)
                print(notification.date)
                notificationsArray.removeAtIndex(index)
                break
            }
        }
        
        let list = NotificationList(notifications: notificationsArray)
        
        let notificationsData = NSKeyedArchiver.archivedDataWithRootObject(list)
        self.defaults.setObject(notificationsData, forKey: "Notifications")
        self.defaults.synchronize() // Sync the defaults to update the data
    }
    
    
    func getAllNotifications() -> [Notification] {
        let arr = [Notification]()
        var notificationsArray = NotificationList(notifications: arr)
        
        if let data = self.defaults.objectForKey("Notifications") as? NSData{
            if let notifications = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? NotificationList {
                notificationsArray = notifications
            }
        }
        return notificationsArray.getArray().sort({$0.date.compare($1.date) == NSComparisonResult.OrderedDescending})
    }
    
    func getNumberOfUnReadNotifications() -> Int{
        var count = 0
        for notification in self.getAllNotifications(){
            if notification.isDone == false{
                count = count + 1
            }
        }
        return count
    }
    
}