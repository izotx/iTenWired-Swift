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
//  NearByViewController.swift
//  Conference App
//
//  Created by Felipe N. Brito on 7/7/16.
//
//

import UIKit
import JMCiBeaconManager

class NearByViewController: UIViewController {

    
    @IBOutlet var collectionView: UICollectionView!
    
    /// iBeaconManager - Awsome Lib :)
    let beaconManager = JMCBeaconManager()
    
    /// iBeacons Data drom the JSON file
    let beaconData = IBeaconData()
    
    /// iBeacons Ranged List
    var beacons = [iBeacon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //CollectionView Delegate
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // iBeaconManager Setup
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(beaconsRanged(_:)), name: iBeaconNotifications.BeaconProximity.rawValue, object: nil)
        
        let registeredBeacons = beaconData.getBeacons()
        
        beaconManager.registerBeacons(registeredBeacons)
        
        beaconManager.startMonitoring({
            
        }) { (messages) in
            print("Error Messages \(messages)")
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: JMCiBeaconManager
extension NearByViewController {
    
    /**Called when the beacons are ranged*/
    func beaconsRanged(notification:NSNotification){
        if let visibleIbeacons = notification.object as? [iBeacon]{
            for beacon in visibleIbeacons{
                beacons.append(beacon)
            }
        }
        collectionView.reloadData()
    }

}


//MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension NearByViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beacons.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as? MenuCellCollectionViewCell
        
        cell?.nameLabel.text = "Name"
        
        return cell!
    }
    
}
