//    Copyright (c) 2016, UWF
//    All rights reserved.
//
//    Redistribution and use in source and binary forms, with or without
//    modification, are permitted provided that the following conditions are met:
//
//    * Redistributions of source code must retain the above copyright notice,
//    this list of conditions and the following disclaimer.
//    * Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
//    * Neither the name of UWF nor the names of its contributors may be used to
//    endorse or promote products derived from this software without specific
//    prior written permission.
//
//    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//    AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//    ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
//    LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//    CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//    SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//    INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//    CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//    ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//    POSSIBILITY OF SUCH DAMAGE.

//  MyItenController.swift
//  Conference App
//  Created by Felipe Brito {felipenevesbrito@gmail.com} on 5/12/16.


import Foundation

/// Controller for MyIten Operations
class MyItenController{
    
    /// For storing data in the NSUserDefaults
    let defaults = NSUserDefaults.standardUserDefaults()
    
    /**
        Adds a event to MyIten storing in the NSUserDefaults
     
        - Parameter event: The Event to be added
    */
    func addToMyIten(event: Event){
        var myItenArray = self.getMyItenEvents()
        myItenArray.append(event)
        
        let myItenData = NSKeyedArchiver.archivedDataWithRootObject(EventList(events: myItenArray))
        
        self.defaults.setObject(myItenData, forKey: "MyIten")
        self.defaults.synchronize()
    }
    
    /**
        Deletes an event from MyIten
     
        - Parameter event: The Event to be removed
    */
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
    
    /**
        Returns all the event of MyIten
     
        - Returns: An array with the events from MyIten
    */
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
    
    /**
        Checks if an event is present in MyIten
     
        - Returns: True if the event is present on MyIten; False otherwise
    */
    func isPresent(event: Event) -> Bool{
        for myItenEvent in getMyItenEvents(){
            
            if myItenEvent.id == event.id {
                return true
            }
        }
        return false 
    }
}