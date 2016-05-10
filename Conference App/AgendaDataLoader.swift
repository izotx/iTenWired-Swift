//
//  AgendaDataLoader.swift
//  Agenda1
//
//  Created by Felipe Neves Brito on 4/5/16.
//  Copyright © 2016 Felipe Neves Brito. All rights reserved.
//

import Foundation

class AgendaDataLoader{

    private var agenda:Agenda = Agenda()
    
    init(){
       
    }
    
    func loadAgenda(){
        let appData = AppData()
        
        let data = appData.getDataFromFile()
       
        if let eventsData = data["events"] as? [NSDictionary]{
            for eventData in eventsData{
                let event =  Event(dictionary: eventData)
                self.agenda.addEvent(event)
            }
        }
    }
    
    func getAgenda() -> Agenda {
        
        self.loadAgenda()   // Parses the data into agenda
        return self.agenda
    }
}