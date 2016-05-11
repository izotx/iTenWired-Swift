//
//  Notification.swift
//  Conference App
//
//  Created by Felipe on 5/10/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

class Notification: NSObject, NSCoding{

    let message : String
    let aditionalData : NSDictionary
    let date : NSDate
    
    init(message:String, aditionalData: NSDictionary, date: NSDate){
        self.message = message
        self.aditionalData = aditionalData
        self.date = date
    }
    
    required convenience init?(coder decoder: NSCoder){
        
        guard let message = decoder.decodeObjectForKey("message") as? String,
            let aditionalData = decoder.decodeObjectForKey("data") as? NSDictionary,
            let date = decoder.decodeObjectForKey("date") as? NSDate
        else{
            return nil
        }
        
        self.init(message: message, aditionalData: aditionalData, date: date)
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.message, forKey: "message")
        coder.encodeObject(self.aditionalData, forKey: "data")
        coder.encodeObject(self.date, forKey: "date")
    }
}