//
//  Track.swift
//  Conference App
//
//  Created by Felipe on 5/20/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

/// Contains the Track's attributes
enum TrackEnum : String{
    case id
    case description
}

/// Contains the information about an event track
class Track{
    
    /// The tracks id
    var id = 0
    
    // The tracks description
    var description = ""
    
    /**
        Initializes the track with the data provided in the dictionary
    */
    init(dictionary: NSDictionary){
        if let idString = dictionary.objectForKey(TrackEnum.id.rawValue) as? String{
            if let id = Int(idString){ // Converts to Int
                self.id = id
            }
        }
        if let description = dictionary.objectForKey(TrackEnum.description.rawValue) as? String{
            self.description = description
        }
    }
}