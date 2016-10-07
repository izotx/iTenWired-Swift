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
    case ObjectAdded
    case ObjectRemoved
}

class NearMeController {
    
    /// iBeacon data from JSON
    private let beaconData = IBeaconData()
    
    /// iBeaconManager - Awsome Lib :)
    private let beaconManager = JMCBeaconManager()
    
    
    /// Active Beacons Near Me
    var activeBeacons = [String : ItenWiredBeacon]()
    
    
    /// Active Near Me Objects
    private var activeNearMe = [iBeaconNearMeProtocol]()
    
    /// Attendee Data from JSON
    private var attendeeData = AttendeeData()
    
    /// Locations Data from JSON
    private var locationsData = LocationData()
    
    deinit{
    
    }
    
    init(){
        
        // iBeaconManager Setup
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(beaconsRanged(_:)), name: iBeaconNotifications.BeaconProximity.rawValue, object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(beaconsStateChanged(_:)), name: iBeaconNotifications.BeaconState.rawValue, object: nil)
 
        
        
        // Get conference beacons from JSON
        let registeredBeacons = beaconData.getBeacons()
        
        /// Register beacons on JMCiBeaconManager
        beaconManager.registerBeacons(registeredBeacons)
        
        
        beaconManager.logging = false
        
        _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(NearMeController.removeOldBeacons), userInfo: nil, repeats: true)
    
    
        
    }

    
    func start(){
        /// Start monitoring for the beacons
        beaconManager.startMonitoring({
            
        }) { (messages) in
            print("Error Messages \(messages)")
        }

    }
    
    func stop(){
        beaconManager.stopMonitoring()
    }
    
    
    @objc func beaconsStateChanged(notification:NSNotification){
       var elements = [Int]()
        
        if let beacon = notification.object as? iBeacon{
           //check state of the object
            if beacon.state == CLRegionState.Unknown || beacon.state == CLRegionState.Outside{
                //delete it
                for (i,object) in activeNearMe.enumerate().reverse() {
                    for otherBeacon in beaconData.getBeaconById(object.getBeaconId()) {
                        if otherBeacon.UUID.equalsIgnoreCase(beacon.UUID) &&
                            otherBeacon.major == beacon.major &&
                            otherBeacon.minor == beacon.minor {
                                //beacon found now we can remove it.
                            let id = "\(beacon.major)\(beacon.minor)\(beacon.UUID)"
                            activeBeacons[id] = nil
                            let el = activeNearMe.removeAtIndex(i)
                            elements.append(el.getId())
                            
                            //print("Remove Beacon")
                            
                        }
                    }
                }
                
            }
        }
        if elements.count > 0{
            NSNotificationCenter.defaultCenter().postNotificationName(NearMeControllerEnum.ObjectRemoved.rawValue, object: elements)

        }
        
    }
    
    @objc func removeOldBeacons() {
        
        var flag = false
        var elements = [iBeaconNearMeProtocol]()
        objc_sync_enter(activeBeacons)
        for beacon in activeBeacons.values {
        
            let now = NSDate()
            
            if beacon.lastRanged.addSeconds(2).isLessThanDate(now) {
                let id = "\(beacon.major)\(beacon.minor)\(beacon.UUID)"
                
                for (i,object) in activeNearMe.enumerate().reverse() {
                    //Check if it is monitored
                    for otherBeacon in beaconData.getBeaconById(object.getBeaconId()) {
                        if otherBeacon.UUID.equalsIgnoreCase(beacon.UUID) &&
                            otherBeacon.major == beacon.major &&
                            otherBeacon.minor == beacon.minor {
                        
                            flag = true
                            activeBeacons[id] = nil
                            let e = activeNearMe.removeAtIndex(i)
                            elements.append(e)
                        }
                    
                    }
                }
            }
        
        }
        objc_sync_exit(activeBeacons)
        
        if flag {
            NSNotificationCenter.defaultCenter().postNotificationName(NearMeControllerEnum.ObjectRemoved.rawValue, object: elements.map({$0.getId()}))
        }
    }
    
    var lastDate = NSDate()
    
    /**Called when the beacons are ranged*/
    @objc func beaconsRanged(notification:NSNotification){
        if let visibleIbeacons = notification.object as? [iBeacon]{
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
        var ids = [Int]()
        let locations = locationsData.getLocationsByiBeacon(beacon)
        if locations.count > 0
        {
            beacon.lastRanged = NSDate()
            activeBeacons[id] = beacon
            for l in locations{
            if activeNearMe.filter({$0 is Location}).filter({($0 as! Location).getId() == l.getId()}).count == 0
                {
                    activeNearMe.append(l)
                    ids.append(l.getId())
                    flag = true
                    
                }
            }
        }
        
        let sponsors = attendeeData.getSponsorsByiBeacon(beacon)
        if sponsors.count > 0
        {
            beacon.lastRanged = NSDate()
            activeBeacons[id] = beacon
            for a in sponsors{
                if activeNearMe.filter({$0 is Sponsor}).filter({($0 as! Sponsor).getId() == a.getId()}).count == 0
                {
                    activeNearMe.append(a)
                    ids.append(a.getId())
                    flag = true
                }
            }
        }
        
        
        let exhibitors =  attendeeData.getExhibitorsByiBeacon(beacon)
        if exhibitors.count > 0
        {
            beacon.lastRanged = NSDate()
            activeBeacons[id] = beacon
            for a in exhibitors{
                if activeNearMe.filter({$0 is Exhibitor}).filter({($0 as! Exhibitor).getId() == a.getId()}).count == 0
                {
                    activeNearMe.append(a)
                    flag = true
                    ids.append(a.getId())
                    
                }
            }
            
        }
        
 
        if flag{
            // Notify that a new beacon was ranged
            NSNotificationCenter.defaultCenter().postNotificationName(NearMeControllerEnum.ObjectAdded.rawValue, object: [ids])
        }
 
    }
    
}

extension JMCBeaconManager {

    static func isInRange( objectProximity : CLProximity, requiredProximity: CLProximity) -> Bool {
       return  objectProximity.sortIndex <= requiredProximity.sortIndex
    }

}