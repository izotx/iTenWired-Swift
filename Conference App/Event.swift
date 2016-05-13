//
//  Event.swift
//  Agenda1
//
//  Created by Felipe Neves Brito on 4/5/16.
//  Copyright © 2016 Felipe Neves Brito. All rights reserved.
//

import Foundation


class Event : NSObject, NSCoding{

    var id:Int = 0
    var name:String = ""
    var summary:String = ""
    var timeStart:String = ""
    var timeStop:String = ""
    var date:String = ""
    var track = 0
    var presentors:[Speaker] = []
    
    init(id:Int){
        self.id = id
    }
    
    init(id:Int, name:String, summary:String, timeStart:String, timeStop:String, date:String){
        self.id = id
        self.name = name
        self.summary = summary
        self.timeStart = timeStart
        self.timeStop = timeStop
        self.date = date
    }
    
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
        
        if let speakers = dictionary.objectForKey(EventEnum.presentors.rawValue) as? [NSDictionary]{
            
            for speaker in speakers {
                let presentor = Speaker(dictionary: speaker)
                self.presentors.append(presentor)
            }
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
    
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeInt(Int32(self.id), forKey: EventEnum.id.rawValue)
        coder.encodeObject(self.name, forKey: EventEnum.name.rawValue)
        coder.encodeObject(self.summary, forKey: EventEnum.summary.rawValue)
        coder.encodeObject(self.timeStart, forKey: EventEnum.timeStart.rawValue)
        coder.encodeObject(self.timeStop, forKey: EventEnum.timeStop.rawValue)
        coder.encodeObject(self.date, forKey: EventEnum.date.rawValue)
    }
}

enum EventEnum : String{
    case id
    case name
    case summary
    case timeStart
    case timeStop
    case date
    case presentors
}
