//
//  Notification.swift
//  Conference App
//
//  Created by Felipe on 5/10/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

/// Notification with infomation of remote notifications
class Notification: NSObject{
    
    /// The title of the notification
    let title: String
    
    /// The content of the notification
    let message: String
    
    /// The date of when the notification was received
    let date : NSDate
    
    /// Indicates if the notification has been read by the user
    var isDone:Bool = false
    
    
    /**
        Initializes a new Notification with the provided data
     
        - Parameters:
            - title: The title of the notification
            - message: The content of the notification
            - received date: The date when the notification was received
            - isDone: Boolean to indicate if the notification was read by the user
    */
    init(message:String, title:String,received date: NSDate, isDone:Bool){
        self.message = message
        self.date = date
        self.isDone = isDone
        self.title = title
    }
    
    /**
        Initializes a new Notification with the provided data
     
        - Parameters:
        - title: The title of the notification
        - message: The content of the notification
        - received date: The date when the notification was received
     */
    init(message:String, title: String, date: NSDate){
        self.message = message
        //self.aditionalData = aditionalData
        self.date = date
        self.title = title
    }
    
    
    required convenience init?(coder decoder: NSCoder){
        
        guard
            let title = decoder.decodeObjectForKey("title") as? String,
            let message = decoder.decodeObjectForKey("message") as? String,
            let date = decoder.decodeObjectForKey("date") as? NSDate,
            let isDone: Bool = decoder.decodeBoolForKey("isDone")
        else{
            return nil
        }
        
        self.init(message: message, title:title, received: date, isDone:isDone)
    }
    
    /**
        Changes the status of the message
        # Possible Notification Status
            - Done: Means the user has read the notification
            - Not Done: Means the user has nor read the notificaton
    
        - Parameter done: Changes the status of the notification; true: means notification read; false: means notification not read yet
    */
    func setDone(done:Bool){
        self.isDone = done
    }
}


// MARK: - NSCoding
extension Notification: NSCoding{
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.title, forKey: "title")
        coder.encodeObject(self.message, forKey: "message")
        //coder.encodeObject(self.aditionalData, forKey: "data")
        coder.encodeObject(self.date, forKey: "date")
        coder.encodeBool(self.isDone, forKey: "isDone")
    }
}