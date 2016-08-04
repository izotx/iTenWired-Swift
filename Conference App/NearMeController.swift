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
//  NearMeController.swift
//  Conference App
//
//  Created by Felipe on 7/8/16.
//
//

import Foundation
import JMCiBeaconManager
import CoreLocation



public enum NearMeControllerEnum : String {
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

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(beaconsStateChanged(_:)), name: iBeaconNotifications.BeaconState.rawValue, object: nil)
        

        
        // Get conference beacons from JSON
        let registeredBeacons = beaconData.getBeacons()
        
        /// Register beacons on JMCiBeaconManager
        beaconManager.registerBeacons(registeredBeacons)
        
        /// Start monitoring for the beacons
        beaconManager.startMonitoring({
            
        }) { (messages) in
            print("Error Messages \(messages)")
        }
        
        _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(NearMeController.removeOldBeacons), userInfo: nil, repeats: true)
    }
    
    @objc func beaconsStateChanged(notification:NSNotification){
        if let beacon = notification.object as? iBeacon{
           //check state of the object
            if beacon.state == CLRegionState.Unknown || beacon.state == CLRegionState.Outside{
                //delete it
                var index = 0
                for object in activeNearMe {
                    if let otherBeacon = beaconData.getBeaconById(object.getBeaconId()) {
                        if otherBeacon.UUID.equalsIgnoreCase(beacon.UUID) &&
                            otherBeacon.major == beacon.major &&
                            otherBeacon.minor == beacon.minor {
                                //beacon found now we can remove it.
                            let id = "\(beacon.major)\(beacon.minor)\(beacon.UUID)"
                            activeBeacons[id] = nil
                            activeNearMe.removeAtIndex(index)
                            //print("Remove Beacon")
                            NSNotificationCenter.defaultCenter().postNotificationName(NearMeControllerEnum.NewBeaconRanged.rawValue, object: nil)
                            
                        }
                    }
                    index = index + 1
                }
            }
        }
    }
    
    @objc func removeOldBeacons() {
        
        var flag = false
        objc_sync_enter(activeBeacons)
//        synchronized(activeBeacons){
//        
//        }
        for beacon in activeBeacons.values {
        
            let now = NSDate()
            
            if beacon.lastRanged.addSeconds(1).isLessThanDate(now) {
                let id = "\(beacon.major)\(beacon.minor)\(beacon.UUID)"
                
                
                var index = 0
                
                for object in activeNearMe {
                    //Check if it is monitored
                    if let otherBeacon = beaconData.getBeaconById(object.getBeaconId()) {
                        if otherBeacon.UUID.equalsIgnoreCase(beacon.UUID) &&
                            otherBeacon.major == beacon.major &&
                            otherBeacon.minor == beacon.minor {
                        
                            flag = true
                            activeBeacons[id] = nil
                            activeNearMe.removeAtIndex(index)
                            print("Remove Beacon")
                        }
                    
                    }
                    
                    index = index + 1
                }
            }
        
        }
        objc_sync_exit(activeBeacons)
        
        if flag {
            NSNotificationCenter.defaultCenter().postNotificationName(NearMeControllerEnum.NewBeaconRanged.rawValue, object: nil)
        }
    }
    
    var lastDate = NSDate()
    
    /**Called when the beacons are ranged*/
    @objc func beaconsRanged(notification:NSNotification){
        if let visibleIbeacons = notification.object as? [iBeacon]{
//            if visibleIbeacons.count == 0 {
//                if abs(lastDate.timeIntervalSince1970 - NSDate().timeIntervalSince1970) >= 5{
//                    activeBeacons.removeAll()
//                    activeNearMe.removeAll()
//                    NSNotificationCenter.defaultCenter().postNotificationName(NearMeControllerEnum.NewBeaconRanged.rawValue, object: nil)
//                    lastDate = NSDate()
//                    return
//                }
//                
//                
//            }
//
            
            for beacon in visibleIbeacons{
                let iTenWiredBeacon = ItenWiredBeacon(with: beacon)
                newBeaconRanged(iTenWiredBeacon)

                
            }
        }
    }
    
    internal func getAllNearMe() -> [iBeaconNearMeProtocol] {
       // return self.activeBeacons.values
        return self.activeNearMe
    }
    

    
    
    private func newBeaconRanged(beacon: ItenWiredBeacon){
        
        var flag = false
        let id = "\(beacon.major)\(beacon.minor)\(beacon.UUID)"
        
        var locations = locationsData.getLocationsByiBeacon(beacon)
        if locations.count > 0
        {
            beacon.lastRanged = NSDate()
            activeBeacons[id] = beacon
            for l in locations{
            if activeNearMe.filter({$0 is Location}).filter({($0 as! Location).getId() == l.getId()}).count == 0
                {
                    activeNearMe.append(l)
                    flag = true
                    
                }
            }
        }
        
        var sponsors = attendeeData.getSponsorsByiBeacon(beacon)
        if sponsors.count > 0
        {
            beacon.lastRanged = NSDate()
            activeBeacons[id] = beacon
            for a in sponsors{
                if activeNearMe.filter({$0 is Sponsor}).filter({($0 as! Sponsor).getId() == a.getId()}).count == 0
                {
                    activeNearMe.append(a)
                    flag = true
                }
            }
        }
        
        
        var exhibitors =  attendeeData.getExhibitorsByiBeacon(beacon)
        if exhibitors.count > 0
        {
            beacon.lastRanged = NSDate()
            activeBeacons[id] = beacon
            for a in exhibitors{
                if activeNearMe.filter({$0 is Exhibitor}).filter({($0 as! Exhibitor).getId() == a.getId()}).count == 0
                {
                    activeNearMe.append(a)
                    flag = true
                    
                }
            }
        }
        
        
//        for sponsor in attendeeData.getSponsers() {
//            
//            if let object = beaconData.getBeaconById(sponsor.iBeaconId) {
//                
//                if object.UUID.equalsIgnoreCase(beacon.UUID) && object.major == beacon.major && object.minor == beacon.minor {
//                        if  JMCBeaconManager.isInRange(beacon.proximity, requiredProximity: sponsor.getBeaconProximity()){
//                            if let _ = activeNearMe.filter({$0 is Sponsor}).filter({($0 as! Sponsor).id == sponsor.id}).first
//                            {
//                                
//                            }
//                            else{
//                                activeNearMe.append(sponsor)
//                                flag = true
//                            }
//    
//                            break
//                        }
//                }
//            }
//        }
//        
//        
//        for exhibitor in attendeeData.getExibitors() {
//            
//            if let object = beaconData.getBeaconById(exhibitor.iBeaconId) {
//                
//                if object.UUID.equalsIgnoreCase(beacon.UUID) && object.major == beacon.major && object.minor == beacon.minor {
//                        if  JMCBeaconManager.isInRange(beacon.proximity, requiredProximity: exhibitor.getBeaconProximity()){
//                            if let _ = activeNearMe.filter({$0 is Exhibitor}).filter({($0 as! Exhibitor).id == exhibitor.id}).first
//                            {
//                                
//                            }
//                            else{
//                                activeNearMe.append(exhibitor)
//                                flag = true
//                            }
//                            
//                            break
//                        }
//                    }
//                }
//        }
//
//        for location in locationsData.getLocations() {
//            
//            if let object = beaconData.getBeaconById(location.iBeaconId) {
//                
//                if object.UUID.equalsIgnoreCase(beacon.UUID) && object.major == beacon.major && object.minor == beacon.minor {
//                        
//                        if  JMCBeaconManager.isInRange(beacon.proximity, requiredProximity: location.getBeaconProximity()){
//                            if let _ = activeNearMe.filter({$0 is Location}).filter({($0 as! Location).id == location.id}).first
//                            {
//                                
//                            }
//                            else{
//                                activeNearMe.append(location)
//                                flag = true
//                            }
//                            
//                            break
//                        }
//                    }
//            }
//        }
        
        if flag{
            // Notify that a new beacon was ranged
            NSNotificationCenter.defaultCenter().postNotificationName(NearMeControllerEnum.NewBeaconRanged.rawValue, object: nil)
        }
 
    }
    
}

extension JMCBeaconManager {

    static func isInRange( objectProximity : CLProximity, requiredProximity: CLProximity) -> Bool {
       return  objectProximity.sortIndex <= requiredProximity.sortIndex
    }

}