//
//  Sponser.swift
//  Conference App
//
//  Created by Felipe Brito {felipenevesbrito@gmail.com} on 5/9/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation


class Sponser: AttendeeProtocol{

    var id:Int = 0
    var name:String = ""
    var level:String = ""
    var description:String = ""
    var logo:String = ""
    var website:String = ""
    
    
    init(dictionary: NSDictionary){
        
        if let id =   dictionary.objectForKey(SponserEnum.id.rawValue) as? Int {
            self.id = id
        }
        
        if let name = dictionary.objectForKey(SponserEnum.name.rawValue) as? String{
            self.name = name
        }
        
        if let level = dictionary.objectForKey(SponserEnum.level.rawValue) as? String{
            self.level = level
        }
        
        if let description = dictionary.objectForKey(SponserEnum.description.rawValue) as? String{
            self.description = description
        }
        
        if let logo = dictionary.objectForKey(SponserEnum.logo.rawValue) as? String{
            self.logo = logo
        }
        
        if let website = dictionary.objectForKey(SponserEnum.logo.rawValue) as? String{
            self.website = website
        }
    }
}


enum SponserEnum:String{
    case id
    case name
    case level
    case description
    case logo
    case website
}
