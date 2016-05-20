//
//  Notification.swift
//  Conference App
//
//  Created by Felipe on 5/10/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

class Notification: NSObject, NSCoding{

    let title : String
    let message : String
   // let aditionalData : NSDictionary
    let date : NSDate
    var isDone:Bool = false
    
    init(message:String, title:String, /*aditionalData: NSDictionary,*/ date: NSDate, isDone:Bool){
        self.message = message
        //self.aditionalData = aditionalData
        self.date = date
        self.isDone = isDone
        self.title = title
    }
    
    init(message:String, title: String, /*aditionalData: NSDictionary,*/ date: NSDate){
        self.message = message
        //self.aditionalData = aditionalData
        self.date = date
        self.title = title
    }
    

    
    required convenience init?(coder decoder: NSCoder){
        
        guard
            let title = decoder.decodeObjectForKey("title") as? String,
            let message = decoder.decodeObjectForKey("message") as? String,
            //let aditionalData = decoder.decodeObjectForKey("data") as? NSDictionary,
            let date = decoder.decodeObjectForKey("date") as? NSDate,
            let isDone: Bool = decoder.decodeBoolForKey("isDone")
        else{
            return nil
        }
        
        self.init(message: message, title:title, /*aditionalData: aditionalData*/ date: date, isDone:isDone)
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.title, forKey: "title")
        coder.encodeObject(self.message, forKey: "message")
        //coder.encodeObject(self.aditionalData, forKey: "data")
        coder.encodeObject(self.date, forKey: "date")
        coder.encodeBool(self.isDone, forKey: "isDone")
    }
    
    func setDone(done:Bool){
        self.isDone = done
    }
    
}