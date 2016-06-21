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

//  AgendaController.swift
//  Agenda1
//
//  Created by Felipe Neves Brito {felipenevesbrito@gmail.com} on 4/5/16.

/// Agenda handler
class AgendaController{

    /// An agenda containing the events
    var agenda:Agenda = Agenda()
    
    /// Agenda DataLoader to load the agenda
    let dataLoader:AgendaDataLoader = AgendaDataLoader()
    
    /**
        Initializes the agenda controller and loads an agenda
    */
    init(){
        self.agenda = self.dataLoader.getAgenda()
    }
    
    func getAgenda() -> Agenda{
        return self.agenda
    }
    /**
        Returns an Event at the specified index.
        Will crash if the index does not exist
     
        - Parameter index: The index of the event requested.
        - Returns: The event at the specific index
    */
    func getEventAt(index:Int) ->Event{
        self.agenda = self.dataLoader.getAgenda()
        return self.agenda.events[index]
    }
    
    
    /**
        Searches an event by its id
     
        - Parameter id: The id of the requested event
        - Returns: The event with the specific id.
     */
    func getById(id:Int)->Event
    {
        var event : Event?
        for tempEvents in self.agenda.events
        {
            if(tempEvents.id == id)
            {
                event = tempEvents
            }
        }
        return event!
    }
    
    /**
        Returns the amount of events stored in the agenda
     
        - Returns: The event count
    */
    func getEventsCount() -> Int{
        return agenda.events.count
    }
}
