//
//  AttendeeController.swift
//  Conference App
//
//  Created by tuong on 4/13/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

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
    
    func getSpeakers() -> [Speaker] {
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
    
    func getSpeackerAtIndex(index: Int) -> Speaker {
        return self.getSpeakers()[index]
    }
    
    func getSpeakerById(id:Int) -> Speaker? {
        
        for speaker in self.getSpeakers() {
        
            if speaker.id == id{
                return speaker
            }
        }
        return nil
    }

}
