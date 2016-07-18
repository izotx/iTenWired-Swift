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
    
    
    /// Near me Controller
    let nearMeController = NearMeController()
    
    /// iBeacons Data drom the JSON file
    let beaconData = IBeaconData()
    
    /// iBeacons Ranged List
    var beacons = [iBeacon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Apply ItenWired Style
        UIConfig()
        
        //CollectionView Delegate
        collectionView.delegate = self
        collectionView.dataSource = self
        

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NearByViewController.newBeaconRanged), name: NearMeControllerEnum.NewBeaconRanged.rawValue, object: nil)
        // Do any additional setup after loading the view.
    }
    
    private func UIConfig() {
        
        self.view.backgroundColor = ItenWiredStyle.background.color.invertedColor
        self.collectionView.backgroundColor = ItenWiredStyle.background.color.invertedColor
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newBeaconRanged() {
        collectionView.reloadData()
    }
    
    
    @IBAction func showMenu(sender: AnyObject) {
    
        if let splitController = self.splitViewController{
            if !splitController.collapsed {
                splitController.toggleMasterView()
                
            } else{
                let rightNavController = splitViewController!.viewControllers.first as! UINavigationController
                rightNavController.popToRootViewControllerAnimated(true)
            }
        }
    
    }

}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension NearByViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nearMeController.getAllNearMe().count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as? NearMeCollectionViewCell
        
        cell?.build(nearMeController.getAllNearMe()[indexPath.row])
        
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if let svc = self.splitViewController where svc.collapsed == false  {
            return CGSize(width: ((collectionView.frame.size.width - 2)) , height: 60)
        }
        
        return CGSize(width: ((collectionView.frame.size.width - 10) / 2)  - 6 , height: 150)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let item = nearMeController.getAllNearMe()[indexPath.row]
        
        if item is Sponsor {
            
            if let sponsor = item as? Sponsor {
            
                let storyboard = UIStoryboard.init(name: "Attendees", bundle: nil)
                let destinationViewController = storyboard.instantiateViewControllerWithIdentifier("SponserDescriptionViewController") as? SponserUIViewController
            
                destinationViewController?.sponser = sponsor
            
                self.navigationController?.pushViewController(destinationViewController!, animated: true)
            }
            
            return
        }
        
        if item is Location {
            
            if let location = item as? Location {
            
                let storyboard = UIStoryboard.init(name: "Location", bundle: nil)
                let destinationViewController = storyboard.instantiateViewControllerWithIdentifier("LocationViewController") as? LocationViewController
                
                destinationViewController?.location = location
                
                self.navigationController?.pushViewController(destinationViewController!, animated: true)
            }
        }
    }
}
