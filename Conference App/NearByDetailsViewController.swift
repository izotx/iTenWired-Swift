//
//  NearByDetailsViewController.swift
//  Conference App
//
//  Created by Janusz Chudzynski on 8/3/16.
//
//

import UIKit
import JMCiBeaconManager
import Haneke


extension AttendeeData{
    func getSponsorsByiBeacon(beacon:ItenWiredBeacon)->[iBeaconNearMeProtocol]{
        let beaconData = IBeaconData()
        var sponsors = [iBeaconNearMeProtocol]()
        for attendee in self.getSponsers() {
            if let object = beaconData.getBeaconById(attendee.iBeaconId) {
                if object.UUID.equalsIgnoreCase(beacon.UUID) && object.major == beacon.major && object.minor == beacon.minor {
                    if  JMCBeaconManager.isInRange(beacon.proximity, requiredProximity: attendee.getBeaconProximity()){
                        
                            sponsors.append(attendee)
                        //return attendee
                    }
                }
            }
        }

        return sponsors
    }

    
    func getExhibitorsByiBeacon(beacon:ItenWiredBeacon)->[iBeaconNearMeProtocol]{
        let beaconData = IBeaconData()
        var exhibitors = [iBeaconNearMeProtocol]()
        
        for attendee in self.getExibitors() {
            if let object = beaconData.getBeaconById(attendee.iBeaconId) {
                if object.UUID.equalsIgnoreCase(beacon.UUID) && object.major == beacon.major && object.minor == beacon.minor {
                    if  JMCBeaconManager.isInRange(beacon.proximity, requiredProximity: attendee.getBeaconProximity()){
                        exhibitors.append(attendee)
                    }
                }
            }
        }
        
        return exhibitors
    }
}


extension LocationData{
    func getLocationsByiBeacon(beacon:ItenWiredBeacon)->[iBeaconNearMeProtocol]{
        let locationsData = LocationData()
        let beaconData = IBeaconData()
        var locations = [iBeaconNearMeProtocol]()
        
        for location in locationsData.getLocations() {
            
            if let object = beaconData.getBeaconById(location.iBeaconId) {
                
                if object.UUID.equalsIgnoreCase(beacon.UUID) && object.major == beacon.major && object.minor == beacon.minor {
                    
                    if  JMCBeaconManager.isInRange(beacon.proximity, requiredProximity: location.getBeaconProximity()){
                        locations.append(location)
                    }
                }
            }
        }

    return locations
    }

}




class NearByDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var objectTitle: UILabel!
    @IBOutlet weak var objectDescription: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var moreInfoButton: UIButton!

    
    var currentClosestIbeacon:iBeacon?
    var currentItem:iBeaconNearMeProtocol?

    var emptyCount = 0 // Optimization
    var emptyThreshold = 5
    var previousCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Apply ItenWired Style
        clearData()
        UIConfig()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NearByDetailsViewController.beaconsRanged(_:)), name:   iBeaconNotifications.BeaconProximity.rawValue, object: nil)
       
        _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(NearByDetailsViewController.removeOldBeacons), userInfo: nil, repeats: true)

    }
    
    @IBAction func showDetails(sender: AnyObject) {
        if let item = currentItem{
            let storyboard = UIStoryboard.init(name: item.getNearMeMenuItem().storyBoardId, bundle: nil)
            
            let destinationViewController = storyboard.instantiateViewControllerWithIdentifier(item.getNearMeMenuItem().viewControllerId) as? iBeaconNearMeViewControllerProtocol
            
            destinationViewController?.build(with: item)
            self.navigationController?.pushViewController((destinationViewController as? UIViewController)!, animated: true)
        
        }
        
    }
    
    
    func removeOldBeacons(){
        var index = 0
        var indexes = [Int]()
        for item in beaconsData{
            
            if NSDate().timeIntervalSinceDate(item.1) > 3 {
                //older than 3 remove
                indexes.append(index)
                if let beacon = currentClosestIbeacon{
                    let id = "\(beacon.major)\(beacon.minor)\(beacon.UUID)"
                    let id1 = item.0
                    if id1 == id {
                        currentClosestIbeacon =  nil
                        clearData()
                        refreshUI()
                       
                        break
                    }
                }
            
            }
            index += 1
        }
    }
    
    private func UIConfig() {
        
        view.backgroundColor = ItenWiredStyle.background.color.invertedColor
        objectTitle.textColor = ItenWiredStyle.background.color.mainColor
        objectDescription.textColor = ItenWiredStyle.background.color.mainColor
    }

    let locationsData = LocationData()
    let attendeeData = AttendeeData()
    
//    let activeBeacons = [String:]
    
    
    private func refreshUI(){
//        if let beacon = currentClosestIbeacon{
//          instructionsLabel.alpha = 0
//           let iTenWiredBeacon = ItenWiredBeacon(with: beacon)
//            if let l = locationsData.getLocationByiBeacon(iTenWiredBeacon)
//            {
//                refreshUI(l)
//                return
//            }
//            if  attendeeData.getSponsorByiBeacon(iTenWiredBeacon).count > 0
//            {
//                let a = attendeeData.getSponsorByiBeacon(iTenWiredBeacon)[0]
//                refreshUI(a)
//                return
//            }
//            
//            if let a = attendeeData.getExhibitorByiBeacon(iTenWiredBeacon)
//            {
//                refreshUI(a)
//                return
//            }
//
//        }
//        else{
//            instructionsLabel.alpha = 1
//        }
    }
    
    private func clearData()
    {
        currentItem = nil
        currentClosestIbeacon = nil
        imageView.image = nil
        objectTitle.text = ""
        objectDescription.text = ""
        moreInfoButton.hidden = true
        
    }
    private func refreshUI(item:iBeaconNearMeProtocol){
        moreInfoButton.hidden = false
        currentItem = item
        if let url = NSURL(string:item.getNearMeIconURL()){
            imageView.hnk_setImageFromURL(url)
        }
        else{
            imageView.image = nil
        }

        objectDescription.text = item.getNearMeDescription()
        objectTitle.text = item.getNearMeTitle()
        
    }
    
    @objc func beaconsRanged(notification:NSNotification){
        guard let  visibleIbeacons = notification.object as? [iBeacon] else{
            //currentClosestIbeacon = nil
           // clearData()
           // refreshUI()
            return
        }
        
        guard let immediateIbeacon = visibleIbeacons.filter({$0.proximity == .Immediate}).first else {
//            //currentClosestIbeacon = nil
//            //clearData()
//            //refreshUI()
//            emptyCount += 1
//            
//            
//            if previousCount > 0{
//                previousCount = 0
//                return
//            }
//            
//            if emptyCount >= emptyThreshold{
//                currentClosestIbeacon = nil
//                clearData()
//                refreshUI()
//                emptyCount = 0
//            }
            
            
                return
            }

        //check if previous count = 0 
        let id = "\(immediateIbeacon.major)\(immediateIbeacon.minor)\(immediateIbeacon.UUID)"
        beaconsData[id] = NSDate()
        
        
        //refresh UI if we found a new iBeacon
        if currentClosestIbeacon != immediateIbeacon {
            currentClosestIbeacon = immediateIbeacon
           
            previousCount = 1
            refreshUI()
            let id = "\(currentClosestIbeacon!.major)\(currentClosestIbeacon!.minor)\(currentClosestIbeacon!.UUID)"
            beaconsData[id] = NSDate()
        }
       }
    
    
    
    var beaconsData = [String:NSDate]()
    
    
    
    }