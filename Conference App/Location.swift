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
//
//
//  Location.swift
//  Conference App
//
//  Created by Felipe N. Brito on 7/18/16.
//
//

import Foundation

enum LocationEmum: String {
    case id
    case name
    case description
    case icon
    case beacon
}

class Location {

    var id = 0
    var name = ""
    var icon = ""
    var description = ""
    var iBeaconId = ""
    
    init(dictionary: NSDictionary) {
    
        if let id = dictionary.objectForKey(LocationEmum.id.rawValue) as? Int {
            self.id = id
        }
        
        if let name = dictionary.objectForKey(LocationEmum.name.rawValue) as? String {
            self.name = name
        }
        
        if let icon = dictionary.objectForKey(LocationEmum.icon.rawValue) as? String {
            self.icon = icon
        }
        
        if let beacon = dictionary.objectForKey(LocationEmum.beacon.rawValue) as? NSDictionary {
            
            if let iBeaconId = beacon.objectForKey(LocationEmum.id.rawValue) as? String {
                self.iBeaconId = iBeaconId
            }
        }
    }
}

//MARK: iBeaconNearMeProtocol
extension Location : iBeaconNearMeProtocol {
    
    func getNearMeIconURL() -> String {
        return icon
    }
    
    func getNearMeTitle() -> String {
        return name
    }
    
    func getBeaconId() -> String {
        return iBeaconId
    }
    
    func getNearMeMenuItem() -> NearMeMenuItem {
        return NearMeMenuItem(storyBoardId: "Location", viewControllerId: "LocationViewController")
    }
}