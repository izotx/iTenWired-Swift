//
//  EventList.swift
//  Conference App
//
//  Created by Felipe on 5/12/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

/// List of events created to be able to save the events on the UserDefaults
class EventList : NSObject{

    /// List of events to be stored
    var events : [Event] = []
    
    /**
        Initializes a Event list with the provided array
     
        - Parameter events: A array with the events to be stored
    */
    init(events:[Event]){
        self.events = events
    }
    
    required convenience init?(coder decoder: NSCoder){
        
        guard let events = decoder.decodeObjectForKey("events") as? [Event] else{
            return nil
        }
        self.init(events: events)
    }
}

//MARK: - NSCoding
extension EventList: NSCoding{
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.events, forKey: "events")
    }
}

