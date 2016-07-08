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
//
//
//  ItenWiredBeacon.swift
//  Conference App
//
//  Created by Felipe on 7/7/16.
//
//

import Foundation
import JMCiBeaconManager


enum ItenWiredBeaconEnum : String {
    case id
    case minor
    case major
    case name
}

class ItenWiredBeacon : iBeacon {
    
    /**
     Initializes the Beacon with the data provided in the dictionary
     */
    init(dictionary: NSDictionary) {
        
        
        var minor: UInt16 = 0
        var major: UInt16 = 0
        var proximityId = ""
        
        if let unwrapedMinor = dictionary.objectForKey(ItenWiredBeaconEnum.minor.rawValue) as? UInt16 {
            minor = unwrapedMinor
        }
        
        if let unwrapedMajor = dictionary.objectForKey(ItenWiredBeaconEnum.major.rawValue) as? UInt16 {
            major = unwrapedMajor
        }
      
        
        if let unwrapedID = dictionary.objectForKey(ItenWiredBeaconEnum.id.rawValue) as? String {
            proximityId = unwrapedID
        }

        super.init(minor: nil, major: nil, proximityId: proximityId)
    }
}


