//
//  EventList.swift
//  Conference App
//
//  Created by Felipe on 5/12/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

class EventList : NSObject, NSCoding{

    var events : [Event] = []
    
    init(events:[Event]){
        self.events = events
    }
    
    required convenience init?(coder decoder: NSCoder){
        
        guard let events = decoder.decodeObjectForKey("events") as? [Event] else{
            return nil
        }
        self.init(events: events)
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.events, forKey: "events")
    }
}

