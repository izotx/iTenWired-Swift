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
    func getSponsorByiBeacon(beacon:ItenWiredBeacon)->iBeaconNearMeProtocol?{
        let beaconData = IBeaconData()
        for attendee in self.getSponsers() {
            if let object = beaconData.getBeaconById(attendee.iBeaconId) {
                if object.UUID.equalsIgnoreCase(beacon.UUID) && object.major == beacon.major && object.minor == beacon.minor {
                    if  JMCBeaconManager.isInRange(beacon.proximity, requiredProximity: attendee.getBeaconProximity()){
                        return attendee
                    }
                }
            }
        }

        return nil
    }

    
    func getExhibitorByiBeacon(beacon:ItenWiredBeacon)->iBeaconNearMeProtocol?{
        let beaconData = IBeaconData()
        for attendee in self.getExibitors() {
            if let object = beaconData.getBeaconById(attendee.iBeaconId) {
                if object.UUID.equalsIgnoreCase(beacon.UUID) && object.major == beacon.major && object.minor == beacon.minor {
                    if  JMCBeaconManager.isInRange(beacon.proximity, requiredProximity: attendee.getBeaconProximity()){
                        return attendee
                    }
                }
            }
        }
        
        return nil
    }
}


extension LocationData{
    func getLocationByiBeacon(beacon:ItenWiredBeacon)->iBeaconNearMeProtocol?{
        let locationsData = LocationData()
        let beaconData = IBeaconData()
        for location in locationsData.getLocations() {
            
            if let object = beaconData.getBeaconById(location.iBeaconId) {
                
                if object.UUID.equalsIgnoreCase(beacon.UUID) && object.major == beacon.major && object.minor == beacon.minor {
                    
                    if  JMCBeaconManager.isInRange(beacon.proximity, requiredProximity: location.getBeaconProximity()){
                        
                        return location
                    }
                }
            }
        }

    return nil
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Apply ItenWired Style
        clearData()
        UIConfig()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NearByDetailsViewController.beaconsRanged(_:)), name:   iBeaconNotifications.BeaconProximity.rawValue, object: nil)
    
    }
    
    @IBAction func showDetails(sender: AnyObject) {
        if let item = currentItem{
            let storyboard = UIStoryboard.init(name: item.getNearMeMenuItem().storyBoardId, bundle: nil)
            
            let destinationViewController = storyboard.instantiateViewControllerWithIdentifier(item.getNearMeMenuItem().viewControllerId) as? iBeaconNearMeViewControllerProtocol
            
            destinationViewController?.build(with: item)
            self.navigationController?.pushViewController((destinationViewController as? UIViewController)!, animated: true)
        
        }
        
    }
    
    
    private func UIConfig() {
        
        view.backgroundColor = ItenWiredStyle.background.color.mainColor
        objectTitle.textColor = ItenWiredStyle.background.color.invertedColor
        objectDescription.textColor = ItenWiredStyle.background.color.invertedColor
    }

    let locationsData = LocationData()
    let attendeeData = AttendeeData()
    
    private func refreshUI(){
        if let beacon = currentClosestIbeacon{
          instructionsLabel.alpha = 0
           let iTenWiredBeacon = ItenWiredBeacon(with: beacon)
            if let l = locationsData.getLocationByiBeacon(iTenWiredBeacon)
            {
                refreshUI(l)
                return
            }
            if let a = attendeeData.getSponsorByiBeacon(iTenWiredBeacon)
            {
                refreshUI(a)
                return
            }
            
            if let a = attendeeData.getExhibitorByiBeacon(iTenWiredBeacon)
            {
                refreshUI(a)
                return
            }

        }
        else{
            instructionsLabel.alpha = 1
        }
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
            currentClosestIbeacon = nil
            clearData()
            refreshUI()
            return
        }
        
        guard let immediateIbeacon = visibleIbeacons.filter({$0.proximity == .Immediate}).first else {
            currentClosestIbeacon = nil
            clearData()
            refreshUI()
            
                return
            }
        //refresh UI if we found a new iBeacon
        if currentClosestIbeacon != immediateIbeacon {
            currentClosestIbeacon = immediateIbeacon
            refreshUI()
        }
        
            
        }
    }