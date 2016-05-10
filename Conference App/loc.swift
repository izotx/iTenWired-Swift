//
//  loc.swift
//  Conference App
//
//  Created by Julian L on 4/12/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

enum locationEnum:String {
    case name
    case latitude
    case longitude
    case date
    case description
}

// Location Object
class loc {
    var name = ""
    var latitude = ""
    var longitude = ""
    var date = ""
    var description = ""
    
    init() { }
    
    // Init with Dictionary
    init(dictionary:NSDictionary) {
        if let name = dictionary.objectForKey(locationEnum.name.rawValue) as? String {
            self.name = name
        }
        if let latitude = dictionary.objectForKey(locationEnum.latitude.rawValue) as? String {
            self.latitude = latitude
        }
        if let longitude = dictionary.objectForKey(locationEnum.longitude.rawValue) as? String {
            self.longitude = longitude
        }
        if let date = dictionary.objectForKey(locationEnum.date.rawValue) as? String {
            self.date = date
        }
        if let description = dictionary.objectForKey(locationEnum.description.rawValue) as? String {
            self.description = description
        }
    }
    
    // Init with String Values
    init(n: String, lat: String, long: String, date: String, desc: String) {
        self.name = n
        self.latitude = lat
        self.longitude = long
        self.date = date
        self.description = desc
    }
    
}