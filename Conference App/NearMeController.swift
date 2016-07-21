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
//  NearMeController.swift
//  Conference App
//
//  Created by Felipe on 7/8/16.
//
//

import Foundation
import JMCiBeaconManager


enum NearMeControllerEnum : String {
    case NewBeaconRanged
}

class NearMeController {

    /// iBeacon data from JSON
    private let beaconData = IBeaconData()
    
    /// iBeaconManager - Awsome Lib :)
    private let beaconManager = JMCBeaconManager()
    
    
    /// Active Beacons Near Me
    private var activeBeacons = [String : ItenWiredBeacon]()
    
    
    /// Active Near Me Objects
    private var activeNearMe = [iBeaconNearMeProtocol]()
    
    /// Attendee Data from JSON
    private var attendeeData = AttendeeData()
    
    /// Locations Data from JSON
    private var locationsData = LocationData()
    
    
    init(){
        
        // iBeaconManager Setup
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(beaconsRanged(_:)), name: iBeaconNotifications.BeaconProximity.rawValue, object: nil)
        
        // Get conference beacons from JSON
        let registeredBeacons = beaconData.getBeacons()

        /// Register beacons on JMCiBeaconManager
        beaconManager.registerBeacons(registeredBeacons)
        
        /// Start monitoring for the beacons
        beaconManager.startMonitoring({
            
        }) { (messages) in
            print("Error Messages \(messages)")
        }
    }
    
    /**Called when the beacons are ranged*/
    @objc func beaconsRanged(notification:NSNotification){
        if let visibleIbeacons = notification.object as? [iBeacon]{
            for beacon in visibleIbeacons{
                
                print(beacon.UUID)
            
                let iTenWiredBeacon = ItenWiredBeacon(with: beacon)
                iTenWiredBeacon.lastRanged = NSDate()
                
                if(activeBeacons[iTenWiredBeacon.id] == nil){
                   newBeaconRanged(iTenWiredBeacon)
                }

                activeBeacons[iTenWiredBeacon.id] = iTenWiredBeacon
            }
        }
    }
    
    internal func getAllNearMe() -> [iBeaconNearMeProtocol] {
        return self.activeNearMe
    }
    
    private func newBeaconRanged(beacon: ItenWiredBeacon){
        
        
        if let object = attendeeData.getSponsers().filter({$0.getBeaconId() == beacon.id}).first{
                activeNearMe.append(object)
        }
        
        
        if let object = attendeeData.getExibitors().filter({$0.getBeaconId() == beacon.id}).first{
            activeNearMe.append(object)
        }
        
        
        if let object = locationsData.getLocations().filter({$0.getBeaconId() == beacon.id}).first{
            activeNearMe.append(object)
        }
               
        // Notify that a new beacon was ranged
        NSNotificationCenter.defaultCenter().postNotificationName(NearMeControllerEnum.NewBeaconRanged.rawValue, object: nil)
    }

}