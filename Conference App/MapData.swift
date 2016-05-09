//
//  AboutData.swift
//  Conference App
//
//  Created by Julian L on 4/12/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

class MapData {
    
    // Array of Conference Locations
    var conferenceLocations: [loc] = []
    
    init() {
        
        let tempDictionary = AppData()
        let dictionaryResult = tempDictionary.getDataFromFile()
        
        // Parse Maps JSON Portion
        let locations = self.parseLocations(dictionaryResult)
        
        // Array of locations
        for locs in locations {
            self.conferenceLocations.append(locs)
        }

    }
    
    // Parses Locations using Dictionary, Returns Array of Locations (as Loc() objects)
    func parseLocations(dictionary:NSDictionary)->[loc] {
        // Array of locations
        var tempLoc: [loc] = []
        
        if let locations = dictionary.objectForKey("locations") as? NSArray {
            for locs in locations {
                let locationName = locs["name"] as? String
                let locationLat = locs["latitude"] as? String
                let locationLong = locs["longitude"] as? String
                let locationDate = locs["date"] as? String
                let locationDesc = locs["description"] as? String
                
                tempLoc.append(loc(n:locationName!, lat: locationLat!, long: locationLong!, date: locationDate!, desc: locationDesc!))
            }
        }
        return tempLoc
        
    }
    
    
}