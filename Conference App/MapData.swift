//    Copyright (c) 2016, Izotx
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
//    * Neither the name of Izotx nor the names of its contributors may be used to
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

//  AboutData.swift
//  Conference App
//
//  Created by Julian L on 4/12/16.


import Foundation

class MapData {
    
    // Array of Conference Locations
    var conferenceLocations: [ConferenceLocation] = []
    
    init() {
        
        let tempDictionary = AppData()
        
        guard let dictionaryResult = tempDictionary.getDataFromFile() else {
            return 
        }
        
        // Parse Maps JSON Portion
        let locations = self.parseLocations(dictionaryResult)
        
        // Array of locations
        for locs in locations {
            self.conferenceLocations.append(locs)
        }
    }
    
    // Parses Locations using Dictionary, Returns Array of Locations (as Loc() objects)
    func parseLocations(dictionary:NSDictionary)->[ConferenceLocation] {
        // Array of locations
        var tempLoc: [ConferenceLocation] = []
        
        if let locations = dictionary.objectForKey("conference_location") as? NSArray {
            for locs in locations {
                
                
                var locationName = ""
                var locationLat = ""
                var locationLong = ""
                var locationDate = ""
                var locationDesc = ""
                
                if let n = locs["name"] as? String{
                    locationName = n
                }
                
                if let n = locs["latitude"] as? String{
                    locationLat = n
                }
                if let n = locs["longitude"] as? String{
                    locationLong = n
                }
                if let n = locs["date"] as? String{
                    locationDate = n
                }

                if let n = locs["description"] as? String{
                    locationDesc = n
                }
                
                /**
                     if let tempLat = CLLocationDegrees(locs.latitude), let tempLong = CLLocationDegrees(locs.longitude), let tempName:String = locs.name, let tempDesc:String = locs.description {
                 */
                
                
                tempLoc.append(ConferenceLocation(name:locationName, latitude: locationLat, longitude: locationLong, date: locationDate, description: locationDesc))
            }
        }
        return tempLoc
    }
}