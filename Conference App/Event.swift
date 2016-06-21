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

//  Event.swift
//  Created by Felipe Neves Brito {felipenevesbrito@gmail.com} on 4/5/16.


import Foundation

/// Event object attribuites names
enum EventEnum : String{
    case id
    case name
    case summary
    case timeStart
    case timeStop
    case date
    case presenters
    case track
}


/// Contains the conference events data
class Event : NSObject{

    /// The events unique ID
    var id:Int = 0
    
    /// The events name
    var name:String = ""
    
    /// The events description and information
    var summary:String = ""
    
    /// The time the event starts
    var timeStart:String = ""
    
    /// The time the event ends
    var timeStop:String = ""
    
    /// The events date
    var date:String = ""
    
    /// The ID if the events Track
    var trackID = 0
    
    /// A list with all the events presentors
    var presentorsIDs:[Int] = []
    
    init(id:Int){
        self.id = id
    }
    
    /**
        Initializes an event with the provided data
     
        - Parameters:
            - id: The event's unique id
            - name: The event's name
            - summary: The event's summary/description
            - timeStart: The time the event starts
            - timeStop: The time the event stops
            - date: The event's date
    */
    init(id:Int, name:String, summary:String, timeStart:String, timeStop:String, date:String){
        self.id = id
        self.name = name
        self.summary = summary
        self.timeStart = timeStart
        self.timeStop = timeStop
        self.date = date
    }
    
    /**
        Initializes an event with the provided dictionary
     
        - Parameter dictionary: A dictionary with an event's data
    */
    init(dictionary: NSDictionary){

        if let IDString = dictionary.objectForKey(EventEnum.id.rawValue) as? String{
            self.id = Int(IDString)!
            
        }
        if let name = dictionary.objectForKey(EventEnum.name.rawValue) as? String{
            self.name = name
        }
        
        if let summary = dictionary.objectForKey(EventEnum.summary.rawValue) as? String{
            self.summary = summary
        }
        
        if let timeStart = dictionary.objectForKey(EventEnum.timeStart.rawValue) as? String{
            self.timeStart = timeStart
        }
        
        if let timeStop = dictionary.objectForKey(EventEnum.timeStop.rawValue) as? String{
            self.timeStop = timeStop
        }
        
        if let date = dictionary.objectForKey(EventEnum.date.rawValue) as? String{
            self.date = date
        }
        
        if let speakersIds = dictionary.objectForKey(EventEnum.presenters.rawValue) as? [String]{
            for id in speakersIds {
                self.presentorsIDs.append(Int(id)!)
            }
        }
        
        if let trackIDString = dictionary.objectForKey(EventEnum.track.rawValue) as? String {
            self.trackID = Int(trackIDString)!
        }
    }
    
    required convenience init?(coder decoder: NSCoder){
        
        guard let id:Int32 = decoder.decodeIntForKey(EventEnum.id.rawValue),
            let name:String = decoder.decodeObjectForKey(EventEnum.name.rawValue) as? String,
            let summary = decoder.decodeObjectForKey(EventEnum.summary.rawValue) as? String,
            let timeStart = decoder.decodeObjectForKey(EventEnum.timeStart.rawValue) as? String,
            let timeStop = decoder.decodeObjectForKey(EventEnum.timeStop.rawValue) as? String,
            let date = decoder.decodeObjectForKey(EventEnum.date.rawValue) as? String
        
        else {
            return nil
        }
        
        self.init(id: Int(id), name: name, summary: summary, timeStart: timeStart, timeStop: timeStop, date: date)
    }
}


//MARK: - NSCoding
extension Event: NSCoding{
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeInt(Int32(self.id), forKey: EventEnum.id.rawValue)
        coder.encodeObject(self.name, forKey: EventEnum.name.rawValue)
        coder.encodeObject(self.summary, forKey: EventEnum.summary.rawValue)
        coder.encodeObject(self.timeStart, forKey: EventEnum.timeStart.rawValue)
        coder.encodeObject(self.timeStop, forKey: EventEnum.timeStop.rawValue)
        coder.encodeObject(self.date, forKey: EventEnum.date.rawValue)
    }
}