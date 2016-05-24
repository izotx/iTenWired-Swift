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

//  Notification.swift
//  Conference App
//  Created by Felipe Brito on 5/10/16.


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
        coder.encodeObject(self.date, forKey: "date")
        coder.encodeBool(self.isDone, forKey: "isDone")
    }
}