//
//  Exibitor.swift
//  Conference App
//
//  Created by Felipe Brito {felipenevesbrito@gmail.com} on 5/9/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

class Exibitor : AttendeeProtocol{
    
    var id:Int = 0
    var name:String = ""
    var description:String = ""
    var logo:String = ""
    var website:String = ""

    init(dictionary: NSDictionary){
        
        if let id = dictionary.objectForKey(ExibitorEnum.id.rawValue) as? Int {
            self.id = id
        }
        
        if let name = dictionary.objectForKey(ExibitorEnum.name.rawValue) as? String {
            self.name = name
        }
        
        if let description = dictionary.objectForKey(ExibitorEnum.description.rawValue) as? String {
            self.description = description
        }
        
        if let logo = dictionary.objectForKey(ExibitorEnum.logo.rawValue) as? String {
            self.logo = logo
        }
        
        if let website = dictionary.objectForKey(ExibitorEnum.website.rawValue) as? String {
            self.website = website
        }
    }
    
}


enum ExibitorEnum : String {
    case id
    case name
    case description
    case logo
    case website
}

