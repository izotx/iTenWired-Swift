//
//  Agenda.swift
//  Agenda1
//
//  Created by Felipe Neves Brito on 4/5/16.
//  Copyright © 2016 Felipe Neves Brito. All rights reserved.
//

/// Agenda contains a list a events from the conference
class Agenda{
    
    /// List of events
    var events:[Event] = []

    /**
        Adds a event to the agenda events
     
        Parameter event: The event to be added
    */
    func addEvent(event:Event){
        self.events.append(event)
    }
}

