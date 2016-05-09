//
//  exhibitorController.swift
//  Conference App
//
//  Created by tuong on 4/15/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

class ExhibitorController{
    
    var attendee:Attendee = Attendee()
    let dataLoader:ExhibitorData = ExhibitorData()
    
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
