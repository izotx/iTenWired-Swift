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

//  NotificationList.swift
//  Conference App
//  Created by Felipe Brito on 5/11/16.

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

