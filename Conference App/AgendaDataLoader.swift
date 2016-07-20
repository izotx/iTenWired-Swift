//    Copyright (c) 2016, Izotx
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
//    * Neither the name of Izotx nor the names of its contributors may be used to
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

//  AgendaDataLoader.swift
//  Agenda1
//
//  Created by Felipe Neves Brito on 4/5/16.


import Foundation

/// Loads agenda data
class AgendaDataLoader{
    
    /// App data loader
    let appData = AppData()
 
    /**
        Returns a Agenda with the events
     
        - Returns: A agenda with the events
    */
    func getAgenda() -> Agenda {
        let agenda = Agenda()
        
        guard let data = appData.getDataFromFile() else {
            return agenda
        }
        
        if let eventsData = data["events"] as? [NSDictionary]{
            for eventData in eventsData{
                let event =  Event(dictionary: eventData)
                agenda.addEvent(event)
            }
        }
        
        return agenda
    }
    
    func getEvents(completion: (events:[Event]) -> Void){
        appData.getDataFromFile { (dictionary) in
            
            var events : [Event] = []
            
            if let eventsData = dictionary["events"] as? [NSDictionary]{
               
                for eventData in eventsData{
                    let event =  Event(dictionary: eventData)
                    events.append(event)
                }
                
                completion(events: events)
            }
        }
    }
}