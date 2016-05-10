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
    
    let dataLoader = AttendeeData()
    
    func getSponsers() -> [Sponser]{
       return dataLoader.getSponsers()
    }
    
    func getSponsersCount() -> Int {
        return getSponsers().count
    }
    
    func getExibitors() -> [Exibitor] {
        return dataLoader.getExibitors()
    }
    
    func getExibitorsCount() -> Int {
        return self.getExibitors().count
    }
    
    func getSpeakers() -> [Speacker] {
        return self.dataLoader.getSpeakers()
    }
    
    func getSpeakersCount() -> Int {
        return self.getSpeakers().count
    }
    
    func getTotalAtendeeCount() -> Int {
        let sponsersCount = self.getSponsersCount()
        let exibitorsCount = self.getExibitorsCount()
        let speackersCount = self.getSpeakersCount()
        
        return sponsersCount + exibitorsCount + speackersCount
    }
    
    
    func getSponserAtIndex(index: Int) -> Sponser {
        return self.getSponsers()[index]
    }
    
    func getExibitorAtIndex(index: Int) -> Exibitor {
        return self.getExibitors()[index]
    }
    
    func getSpeackerAtIndex(index: Int) -> Speacker {
        return self.getSpeakers()[index]
    }
    
    
    
    
    
    //FIXME: remove all code below
    var attendee:Attendee = Attendee()
    let dataLoader2:AttendeeData = AttendeeData()
    
    init(){
       // self.attendee = self.dataLoader2.getAttendee()
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
