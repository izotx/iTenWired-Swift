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

//  Location.swift
//  Conference App
//  Created by Julian L on 4/12/16.

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