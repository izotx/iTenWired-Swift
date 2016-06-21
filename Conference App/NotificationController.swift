//    Copyright (c) 2016, UWF
//    All rights reserved.
//
//    Redistribution and use in source and binary forms, with or without
//    modification, are permitted provided that the following conditions are met:
//
//    * Redistributions of source code must retain the above copyright notice,
//    this list of conditions and the following disclaimer.
//    * Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
//    * Neither the name of UWF nor the names of its contributors may be used to
//    endorse or promote products derived from this software without specific
//    prior written permission.
//
//    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//    AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//    ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
//    LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//    CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//    SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//    INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//    CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//    ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//    POSSIBILITY OF SUCH DAMAGE.

//  NotificationController.swift
//  Conference App
//  Created by Felipe Brito {felipenevesbrito@gmail.com} on 5/10/16.

import Foundation
import UIKit

/// Handles Notification operations
class NotificationController{
    
    /// UserDafaults instance to save data to NSUserDefaults
    let defaults = NSUserDefaults.standardUserDefaults()
    
    /**
        Saves a notification to the NSUserDefaults
     
        - Parameter notification: The notification to be added
    */
    func addNotification(notification:Notification){
        
        var notificationsArray = self.getAllNotifications()
        
        for n in notificationsArray {
            if n.title == notification.title && n.title == notification.title && n.date.timeIntervalSince1970 == notification.date.timeIntervalSince1970 {
                return
            }
        }
        
        notificationsArray.append(notification)

        let notificationsData = NSKeyedArchiver.archivedDataWithRootObject(NotificationList(notifications: notificationsArray))
        
        self.defaults.setObject(notificationsData, forKey: "Notifications")
        self.defaults.synchronize() // Sync the defaults to update the data
    }
    
    /**
        Deletes a notification from the NSUserDefaults
     
        - Parameter notification: The notification to be added
    */
    func deleteNotification(notification:Notification){
        
        var notificationsArray = self.getAllNotifications()
        
        for index in Range(0 ..< notificationsArray.count) {
            if notificationsArray[index].date.isEqualToDate(notification.date)
                && notificationsArray[index].message == notification.message
            {
                print(notificationsArray[index].date)
                print(notification.date)
                notificationsArray.removeAtIndex(index)
                break
            }
        }
        
        let list = NotificationList(notifications: notificationsArray)
        NSKeyedArchiver.setClassName("NotificationList", forClass: NotificationList.self)
        let notificationsData = NSKeyedArchiver.archivedDataWithRootObject(list)

        self.defaults.setObject(notificationsData, forKey: "Notifications")
        self.defaults.synchronize() // Sync the defaults to update the data
    }
    
    /**
        Returns all notifications present in the NSUserDefaults
     
        - Resturns: An array of with the notifications present in the NSUserDefaults
     
    */
    func getAllNotifications() -> [Notification] {
        let arr = [Notification]()
        var notificationsArray = NotificationList(notifications: arr)
        
        NSKeyedUnarchiver.setClass(NotificationList.self, forClassName: "NotificationList")
        if let data = self.defaults.objectForKey("Notifications") as? NSData{
            if let notifications = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? NotificationList {
                notificationsArray = notifications
            }
        }
        return notificationsArray.getArray().sort({$0.date.compare($1.date) == NSComparisonResult.OrderedDescending})
    }
    
    /**
        Returns the number of unread notifications by the User 
     
        - Returns: The number of unread notifications
    */
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