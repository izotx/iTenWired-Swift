//
//  AttendeeController.swift
//  Conference App
//
//  Created by tuong on 4/13/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation
//control
class AttendeeController{
    
    var attendee:Attendee = Attendee()
    let dataLoader:AttendeeData = AttendeeData()
    
    init(){
        self.attendee = self.dataLoader.getAttendee()
    }
    
    func getAgenda() -> Attendee{
        return self.attendee
    }
    
    func getEventAt(index:Int) ->Event{
        return self.attendee.event[index]
    }
    
    func getEventsCount() -> Int{
        return attendee.event.count
    }
}
