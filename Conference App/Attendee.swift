//
//  Attendee.swift
//  Conference App
//
//  Created by tuong on 4/13/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

//add event
class Attendee{
    var event:[Event] = []
    
    func addEvent(event:Event){
        self.event.append(event)
    }
    
    func addEvents(events:[Event]){
        self.event.appendContentsOf(events)
    }

}