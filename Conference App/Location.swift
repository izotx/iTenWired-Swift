//
//  loc.swift
//  Conference App
//
//  Created by Julian L on 4/12/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

///Location object attributes.
enum locationEnum:String {
    case name
    case latitude
    case longitude
    case date
    case description
}


// Location object stores a locations informtion
class Location {
    
    /// The locations name
    var name = ""
    
    /// The location latitude
    var latitude = ""
    
    /// The locations longitude
    var longitude = ""
    
    //FIXME: is the date needed?
    // The locations date
    var date = ""
    
    // The locations description
    var description = ""
    
    /**
        Initializes the Location with the provided data
     
        - Paramaters:
            - name: The locations name
            - latitude: The locations latitude
            - longitude: The locations longitude
            - date: The locations date -- Not sure why
            - description: The locations description
     */
    init(name: String, latitude: String, longitude: String, date: String, description: String) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.date = date
        self.description = description
    }
    
    /**
        Initializes a new location usig the provided NSDictionary 
     
        - Parameter dictionary: A dictionary with the locations data
    */
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
}