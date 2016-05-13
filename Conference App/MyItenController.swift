//
//  MyItenController.swift
//  Conference App
//
//  Created by Felipe on 5/12/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

class MyItenController{
    
    let defaults = NSUserDefaults.standardUserDefaults()

    func addToMyIten(event: Event){
        var myItenArray = self.getMyItenEvents()
        myItenArray.append(event)
        
        let myItenData = NSKeyedArchiver.archivedDataWithRootObject(EventList(events: myItenArray))
        
        self.defaults.setObject(myItenData, forKey: "MyIten")
        self.defaults.synchronize()
    }
    
    func deleteFromMyIten(event:Event){
        var eventsArray = self.getMyItenEvents()
        
        for index in Range(0 ..< eventsArray.count){
            if eventsArray[index].id == event.id{
                eventsArray.removeAtIndex(index)
                break
            }
        }
        let myItenData = NSKeyedArchiver.archivedDataWithRootObject(EventList(events: eventsArray))
        self.defaults.setObject(myItenData, forKey: "MyIten")
        self.defaults.synchronize()
    }
    
    func getMyItenEvents() -> [Event]{
        let arr = [Event]()
        var eventsArray = EventList(events: arr)
        
        if let data = self.defaults.objectForKey("MyIten") as? NSData{
            if let events = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? EventList{
                eventsArray = events
            }
        }
        return eventsArray.events
    }
}