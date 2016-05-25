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

//  AttendeeController.swift
//  Conference App
//
//  Created by tuong on 4/13/16.


import Foundation

class AttendeeController{
    
    /// The Attendee's data class
    let dataLoader = AttendeeData()
    
    /**
        Returns all sponsers from the conference
     
        - Returns: An array with the confference Sponsers
    */
    func getSponsers() -> [Sponser]{
       return dataLoader.getSponsers()
    }
    
    /**
     Returns the amount of sponsers in the conference
     
     - Returns: The amount of sponsers
     */
    func getSponsersCount() -> Int {
        return getSponsers().count
    }
    
    /**
     Returns all exhibitors from the conference
     
     - Returns: An array with the confference Exhibitors
     */
    func getExibitors() -> [Exibitor] {
        return dataLoader.getExibitors()
    }
    
    /**
     Returns the amount of exhibitors in the conference
     
     - Returns: The amount of exhibitors
     */
    func getExibitorsCount() -> Int {
        return self.getExibitors().count
    }
    
    /**
     Returns all speakers from the conference
     
     - Returns: An array of the confference Speakers
     */
    func getSpeakers() -> [Speaker] {
        return self.dataLoader.getSpeakers()
    }
    
    /**
        Returns the amount of speakes in the conference
     
     - Returns: The amount of speakers
     */
    func getSpeakersCount() -> Int {
        return self.getSpeakers().count
    }
    
    /**
     Returns the total amount of attenddes in the conference (Speakers + Exhibitors + Sponsers)
     
     - Returns: The amount of Attendees (Speakers + Exhibitors + Sponsers)
     */
    func getTotalAtendeeCount() -> Int {
        return getSponsersCount() + getExibitorsCount() + getSpeakersCount()
    }
    
    /**
        Returns a sponser at the specified index
        Will crash if index dose not exist
     
        - Returns: A sponser from the specified index
    */
    func getSponserAtIndex(index: Int) -> Sponser {
        return self.getSponsers()[index]
    }
    
    /**
     Returns a exhibitor at the specified index
     Will crash if index dose not exist
     
     - Returns: A exhibitor from the specified index
     */
    func getExibitorAtIndex(index: Int) -> Exibitor {
        return self.getExibitors()[index]
    }
    
    /**
     Returns a speaker at the specified index
     Will crash if index dose not exist
     
     - Returns: A speaker from the specified index
     */
    func getSpeackerAtIndex(index: Int) -> Speaker {
        return self.getSpeakers()[index]
    }
    
    /**
     Returns a speaker with the specified id
     
     - Returns: A sponser with the specified id or Nil if not exists
     */
    func getSpeakerById(id:Int) -> Speaker? {
        
        for speaker in self.getSpeakers() {
        
            if speaker.id == id{
                return speaker
            }
        }
        return nil
    }
}
