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


extension RangeReplaceableCollectionType where Generator.Element : Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func removeObject(object : Generator.Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
}

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
        //Currently visible ibeacons
        var visibleITenWiredBeacons = [ItenWiredBeacon]()
        if let visibleIbeacons = notification.object as? [iBeacon]{

            //Sanitizing th beacons - checking if we are monitoring them
            let visibleITenWiredCandidateBeacons = visibleIbeacons.map({return ItenWiredBeacon(with:$0)}) as [ItenWiredBeacon]
            let alliTenWiredBeacons = beaconData.getBeacons() //All iTen Wired iBeacons
            
            for beacon in visibleITenWiredCandidateBeacons{
                if let first = alliTenWiredBeacons.filter({$0 == beacon}).first{
                    //Make sure we are using the right kind of id
                    //beacon.id = first.id
                    visibleITenWiredBeacons.append(first)
                }
            }
            
            for beacon in visibleITenWiredBeacons{
                
                print(beacon.UUID)
                beacon.lastRanged = NSDate()
                if(activeBeacons[beacon.id] == nil){
                    activeBeacons[beacon.id] = beacon
                }
             }
            
            //list will contain all visible beacons + some that should not be visible anymore 
            
    //        var toDelete = [ItenWiredBeacon]()
            //loop through activeBeacons and check if they are in visible beacons if not ignore
           
//            //Remove it from the active beacons list
//            for (_, beacon) in activeBeacons{
//                if !visibleITenWiredBeacons.contains(beacon){
//                    toDelete.append(beacon)
//                }
//            }

//Remove not visible ibeacons
//            for beacon in toDelete{
//  //              activeBeacons[beacon.id] = nil
//               //remove not visible associated objecs
//               //get index
//                var index = -1;
//                for (i,a) in activeNearMe.enumerate(){
//                    if a.getBeaconId() == beacon.id{
//                        index = i
//                    }
//                }
//                if index != -1 {
////                    activeNearMe.removeAtIndex(index)
//                }
//            }
           
        }else{//No beacons are currently visible
            //send update anyways 
             activeNearMe.removeAll()
        }
        
        
        //Notify about changes
        newBeaconRanged(visibleITenWiredBeacons)
    }
    
    internal func getAllNearMe() -> [iBeaconNearMeProtocol] {
        return self.activeNearMe
    }
    
    
    
    
    
    private func newBeaconRanged(candidateBeacons: [ItenWiredBeacon]){
       
//        let loc = locationsData.getLocations()
//        let beacons = beaconData.getBeacons()
//        let exh = attendeeData.getExibitors()
//        let spo = attendeeData.getSponsers()
//        let spe = attendeeData.getSpeakers()
//        
//        //we have a candidate beacon and we need to match it with a location
//        //locations
//        
        
        for beacon in candidateBeacons{

            //check if we already added it or not
            if let _  = activeNearMe.filter({$0.getBeaconId() == beacon.id}).first
            {
                continue
            }
            
            if let object = attendeeData.getSponsers().filter({$0.getBeaconId() == beacon.id}).first {
                activeNearMe.append(object)
            }
            
            if let object = attendeeData.getExibitors().filter({$0.getBeaconId() == beacon.id}).first{
                activeNearMe.append(object)
            }
            
            if let object = locationsData.getLocations().filter({$0.getBeaconId() == beacon.id}).first{
                activeNearMe.append(object)
            }
        }
        
        // Notify that a new beacon was ranged
        NSNotificationCenter.defaultCenter().postNotificationName(NearMeControllerEnum.NewBeaconRanged.rawValue, object: nil)
    }

}