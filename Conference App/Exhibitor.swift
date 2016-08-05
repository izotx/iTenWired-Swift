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

//  Exibitor.swift
//  Conference App
//  Created by Felipe Brito {felipenevesbrito@gmail.com} on 5/9/16.


import Foundation
import CoreLocation
import JMCiBeaconManager

// The exhibitors attributes
enum ExibitorEnum : String {
    case id
    case name
    case description
    case logo
    case website
    case beacon
}

/// Information of the conference Exhibitors
class Exhibitor : AttendeeProtocol{
    
    /// Exhibitors unique id
    var id:Int = 0
    
    /// Exhibitors name
    var name:String = ""
    
    ///Exhibitors description
    var description:String = ""
    
    /// Exhibitors URL logo
    var logo:String = ""
    
    ///Exhibitos website URL
    var website:String = ""
    
    /// iBeacon ID
    var iBeaconId = ""
    
    /// Beacon proximity
    var beaconProximity : CLProximity!
    
    init(dictionary: NSDictionary){
        
        if let id = (dictionary.objectForKey(ExibitorEnum.id.rawValue) as? NSString)?.integerValue {
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
        
        if let beacon = dictionary.objectForKey(ExibitorEnum.beacon.rawValue) as? NSDictionary {
            
            if let beaconId = beacon.objectForKey(ExibitorEnum.id.rawValue) as? String {
                self.iBeaconId = beaconId
            }
            
            if let sensitivity = beacon.objectForKey(SponserEnum.sensitivity.rawValue) as? String {
                
                if sensitivity.equalsIgnoreCase("near") {
                    self.beaconProximity = CLProximity.Near
                } else if sensitivity.equalsIgnoreCase("far") {
                    self.beaconProximity = CLProximity.Far
                } else if sensitivity.equalsIgnoreCase("immediate") {
                    self.beaconProximity = CLProximity.Immediate
                } else {
                    self.beaconProximity = CLProximity.Unknown
                }
            }
        }
        
    }
}

//MARK: iBeaconNearMeProtocol
extension Exhibitor : iBeaconNearMeProtocol {
    func getNearMeDescription() -> String {
        return description
    }
    
    func getId() -> Int {
        return id 
    }
    
    func getNearMeIconURL() -> String {
        return logo
    }
    
    func getNearMeTitle() -> String {
        return name
    }
    
    func getBeaconId() -> String {
        return iBeaconId
    }
    
    func getBeaconProximity() -> CLProximity {
        return beaconProximity
    }
    
    func getNearMeMenuItem() -> NearMeMenuItem {
        return NearMeMenuItem(storyBoardId: "Attendees", viewControllerId: "SponserDescriptionViewController")
    }
}