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
       
        let minValue = min(200, ((collectionView.frame.size.width - 20) / 2  - 6))
        return CGSize(width: minValue, height: 150)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let item = nearMeController.getAllNearMe()[indexPath.row]
        let storyboard = UIStoryboard.init(name:  item.getNearMeMenuItem().storyBoardId, bundle: nil)
        
        let destinationViewController = storyboard.instantiateViewControllerWithIdentifier(item.getNearMeMenuItem().viewControllerId) as? iBeaconNearMeViewControllerProtocol
        
        destinationViewController?.build(with: item)
        self.navigationController?.pushViewController((destinationViewController as? UIViewController)!, animated: true)
    }
}
