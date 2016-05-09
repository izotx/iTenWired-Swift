//
//  Event.swift
//  Agenda1
//
//  Created by Felipe Neves Brito on 4/5/16.
//  Copyright © 2016 Felipe Neves Brito. All rights reserved.
//

import Foundation
//data structure
class Event{

    var id:Int = 0
    var name:String = ""
    var summary:String = ""
    var timeStart:String = ""
    var timeStop:String = ""
    var date:String = ""
    
    
    // atendee data added by Tin
    //attendees
    var attendeeName: String = ""
    var logo:String = ""
    var level: String = ""
    var description: String = ""
    var jobTitle : String = ""
    var company: String = ""
    var linkedin : String = ""
    var email : String = ""
    var website:String = ""
    var type:String = ""
    
    init(id:Int){
        self.id = id
    }
    
    init(dictionary: NSDictionary){
        
        var IDString:String
        if let IDString = dictionary.objectForKey(EventEnum.id.rawValue) as? String{
            self.id = Int(IDString)!
            
        } else {
         
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
        
        
        // atendee data added by Tin
        if let logo = dictionary.objectForKey(EventEnum.logo.rawValue) as? String{
            self.logo = logo
        }
        if let level = dictionary.objectForKey(EventEnum.level.rawValue) as? String{
            self.level = level
        }
        if let description = dictionary.objectForKey(EventEnum.description.rawValue) as? String{
            self.description = description
        }
        if let jobTitle = dictionary.objectForKey(EventEnum.jobTitle.rawValue) as? String{
            self.jobTitle = jobTitle
        }
        if let company = dictionary.objectForKey(EventEnum.company.rawValue) as? String{
            self.company = company
        }
        if let linkedin = dictionary.objectForKey(EventEnum.linkedin.rawValue) as? String{
            self.linkedin = linkedin
        }
        if let email = dictionary.objectForKey(EventEnum.email.rawValue) as? String{
            self.email = email
        }
        if let website = dictionary.objectForKey(EventEnum.website.rawValue) as? String{
            self.website = website
        }
        if let type = dictionary.objectForKey(EventEnum.type.rawValue) as? String{
            self.type = type
        }
        
    }
}


enum EventEnum : String{
    case id
    case name
    case summary
    case timeStart
    case timeStop
    case date
    
    // atendee data added by Tin
    case logo
    case level
    case description
    case jobTitle
    case company
    case linkedin
    case email
    case website
    case type
}
