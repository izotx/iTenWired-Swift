//
//  Track.swift
//  Conference App
//
//  Created by Felipe on 5/20/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

enum TrackEnum : String{
    case id
    case description
}

class Track{

    var id = 0
    var description = ""
    
    
    init(dictionary: NSDictionary){
        if let idString = dictionary.objectForKey(TrackEnum.id.rawValue) as? String{
            self.id = Int(idString)!
        }
        
        if let description = dictionary.objectForKey(TrackEnum.description.rawValue) as? String{
            self.description = description
        }
    }
}