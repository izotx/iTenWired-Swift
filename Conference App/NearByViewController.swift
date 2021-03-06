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

class NearbyHeader:UICollectionReusableView{
    
    @IBOutlet weak var label: UILabel!
}


class NearByViewController: UIViewController {

    var imageCache = [String:UIImage]()
    @IBOutlet var collectionView: UICollectionView!
    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    // 2
    var dataTask: NSURLSessionDataTask?
    
    /// Near me Controller
    let nearMeController = NearMeController()
    
//    /// iBeacons Data drom the JSON file
//    let beaconData = IBeaconData()
//    
//    /// iBeacons Ranged List
//    var beacons = [iBeacon]()

    
    var datasource = [iBeaconNearMeProtocol]()
    

    deinit{
    
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
      //  nearMeController.stopUpdates()
        nearMeController.stop()
        //datasource.removeAll()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.datasource = nearMeController.getAllNearMe()
        self.collectionView.reloadData()
        nearMeController.start()

    }
    
    var serialQueue = dispatch_queue_create("com.blah.queue", DISPATCH_QUEUE_SERIAL);
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Apply ItenWired Style
        UIConfig()
        
//        dispatch_async(serialQueue) {
//            dispatch_async(dispatch_get_main_queue(), {
//                self.datasource = self.nearMeController.getAllNearMe()
//            })
//        }
        
 
        
        //CollectionView Delegate
        collectionView.delegate = self
        collectionView.dataSource = self
        

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(beaconsAdded(_:)), name: NearMeControllerEnum.ObjectAdded.rawValue, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(beaconsRemoved(_:)), name: NearMeControllerEnum.ObjectRemoved.rawValue, object: nil)

    
    }
    
    var lastUpdate:NSDate = NSDate()
    
    
    @objc func beaconsAdded(n:NSNotification){
         var array = [NSIndexPath]()
        print("adding to the array")
   
        if let bp = n.object as? Array<Int>{
        var flag = false

           
            for (i,k) in bp.enumerate() {
                if datasource.filter({$0.getId() == k}).count == 0{
                    //get the object 
                    if let b = nearMeController.getAllNearMe().filter({$0.getId() == k}).first{
                                self.datasource.insert(b, atIndex: i)
                                //let ip = NSIndexPath(forItem: i, inSection: 0)
                        
                              //  array.append(ip)
                               flag = true

                    }
                }
            }
            
            if flag{
                dispatch_async(dispatch_get_main_queue(), { 
                    //self.collectionView.insertItemsAtIndexPaths(array)
                    self.collectionView.reloadData()
                })
                

                
                
////                let timeInterval = lastUpdate.timeIntervalSinceNow
////                if timeInterval < -5{
//                    collectionView.reloadData()
//                    lastUpdate = NSDate()
////                }
            }
        }
    }
    
    
    @objc func beaconsRemoved(n:NSNotification){
        
        var flag = false
        if let bp = n.object as? [Int] where bp.count > 0 {
            
            for (i,object) in datasource.enumerate().reverse() {
                if bp.filter({$0 == object.getId()}).count > 0{
                    datasource.removeAtIndex(i)
                    let ip = NSIndexPath(forItem: i, inSection: 0)
                    collectionView.deleteItemsAtIndexPaths([ip])
                    flag = true
                }
            }
        }
        
//        if flag {
////            let timeInterval = lastUpdate.timeIntervalSinceNow
////            if timeInterval < -5{
//                collectionView.reloadData()
//                lastUpdate = NSDate()
////            }
//        }
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
        
        
        //collectionView.reloadData()
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
//        return nearMeController.getAllNearMe().count
        return  self.datasource.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as? NearMeCollectionViewCell
        let item =  self.datasource[indexPath.row]
        cell?.build(item)
        
        ///assign image
        // If this image is already cached, don't re-download
        let url = item.getNearMeIconURL()
        
        
        if let img = imageCache[url] {
            cell?.imageView.image = img
            cell?.title.alpha = 0
        }
        else {
            cell?.title.text = item.getNearMeTitle()
            cell?.title.alpha = 1
            if let nsurl = NSURL(string: url){
                dataTask = defaultSession.dataTaskWithURL(nsurl) {[weak self]
                    data, response, error in
                    // 7
                    if let error = error {
                        print(error.localizedDescription)
                    } else if let httpResponse = response as? NSHTTPURLResponse {
                        if httpResponse.statusCode == 200 {
                            //self.updateSearchResults(data)
                            if let data = data, image = UIImage(data: data){
                               dispatch_async(dispatch_get_main_queue(), { 
                                self?.imageCache[url] = image
                                //reload collection view
                                //normally I would reload only cell but since the cells can switch places we will just reload all.
                                
                                
                                self?.collectionView.reloadData()
                                cell?.title.alpha = 0
                                //collectionView.reloadItemsAtIndexPaths([indexPath])
                                
                               })
                            }
                        }
                    }
                }
                // 8
                dataTask?.resume()
            }
            
           }

        cell?.contentView.frame = cell!.bounds
        cell?.contentView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]

        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
        //2
        case UICollectionElementKindSectionHeader:
            //3
            let headerView =
                collectionView.dequeueReusableSupplementaryViewOfKind(kind,
                                                                      withReuseIdentifier: "collectionViewHeader",
                                                                      forIndexPath: indexPath)
                    as! NearbyHeader
            
            
//            let count = nearMeController.getAllNearMe().count
            let count = self.datasource.count
            
            if count == 0{
                headerView.label.text = "Scanning for nearby POIs"
            }
            else{
                let t =  count > 1 ? " POIs" :  "POI"
                headerView.label.text = "\(count) \(t) Nearby"
            }
            return headerView
        default:
            //4

            
            assert(false, "Unexpected element kind")
        }
         return UICollectionReusableView()
    }
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
       
        let w = collectionView.frame.width
        let left = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInset.left
        let right = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInset.left
        let spacing = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing
        
        let adjw = w - (left + right + spacing + 2)
        let cellW = adjw / 2.0
        let h:CGFloat = 150
        
    
        return CGSize(width: cellW , height: h)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let item =  self.datasource[indexPath.row]
        let storyboard = UIStoryboard.init(name:  item.getNearMeMenuItem().storyBoardId, bundle: nil)
        
        let destinationViewController = storyboard.instantiateViewControllerWithIdentifier(item.getNearMeMenuItem().viewControllerId) as? iBeaconNearMeViewControllerProtocol
        
        destinationViewController?.build(with: item)
        self.navigationController?.pushViewController((destinationViewController as? UIViewController)!, animated: true)
    
//        if item.dynamicType == Location.self{
//            let storyboard = UIStoryboard.init(name:"Location", bundle:nil)
//            
//        }
//        else{
//        
//        
//        }
        
//        if item.isClass(){
//            
//        }
    
    
    }
}
