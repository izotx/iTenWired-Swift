//
//  Agenda.swift
//  Agenda1
//
//  Created by Felipe Neves Brito on 4/5/16.
//  Copyright © 2016 Felipe Neves Brito. All rights reserved.
//

class Agenda{

    var events:[Event] = []

    func addEvent(event:Event){
        self.events.append(event)
    }
    
    func addEvents(events:[Event]){
        self.events.appendContentsOf(events)
    }
}

