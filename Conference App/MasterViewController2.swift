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
//    MasterViewController2.swift
//    Conference App
//    Created by Felipe Neves {felipenevesbrito@gmail.com} on 5/18/16.



import UIKit
import CoreData

class MasterViewController2 : UIViewController{
    
    let screenBounds = UIScreen.mainScreen().bounds
    var menuItems:[MenuItem] = []
    let reach = Reach()
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    
    override func viewWillAppear(animated: Bool) {
        if reach.connectionStatus().description != "Offline"{
            /*dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                
                let aboutData = AboutData()
                let about = aboutData.getAbout()
                
                let url = NSURL(string: about.image)
                let data = NSData(contentsOfURL: url!)
                
                dispatch_async(dispatch_get_main_queue()){
                
                    self.logo.image = UIImage(data: data!)
                }                
            }*/
        }
        
        self.collectionView.reloadData()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMenuItems()
        self.UIConfig()
        
        //CollectionView Deleagte
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // SplitView Delegate
        splitViewController?.delegate = self
    }
    
    internal func UIConfig(){
        self.collectionView.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.view.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.logo.image = UIImage(named: "logo-16.png")
    }
    
    /**
        Loads the menu items into the MenuItems array
    */
    internal func loadMenuItems(){
        let map = MenuItem(storyboardId: "MapView", viewControllerId: "MapStoryboard", name: "Map", imageUrl: "MapMFilled-50.png")
        self.menuItems.append(map)
        
        let agenda = MenuItem(storyboardId: "AgendaMain", viewControllerId: "AgendaInitial", name: "Agenda", imageUrl: "AgendaFilled-50.png")
        self.menuItems.append(agenda)
        
        let myIten = MenuItem(storyboardId: "ItineraryStoryboard", viewControllerId: "Itinerary", name: "My Iten", imageUrl: "MyItenFilled-50.png")
        self.menuItems.append(myIten)
        
        let socialMedia = MenuItem(storyboardId: "SocialMedia", viewControllerId: "SocialMediaRoot", name: "Social Media", imageUrl: "SocialMediaFilled-50.png")
        self.menuItems.append(socialMedia)
        
        let liveBroadcast = MenuItem(storyboardId: "LiveBroadcast", viewControllerId: "LiveBroadcast", name: "Live Broadcast", imageUrl: "LiveBroadcastFilled-50.png")
        self.menuItems.append(liveBroadcast)
        
        let about = MenuItem(storyboardId: "AboutView", viewControllerId: "AboutView", name: "About", imageUrl: "AboutFilled-50.png")
        self.menuItems.append(about)
        
        let atendees = MenuItem(storyboardId: "Attendees", viewControllerId: "Attendee", name: "Who is here", imageUrl: "WhoFilled-50.png")
        self.menuItems.append(atendees)
        
        let notifications = MenuItem(storyboardId: "Notification", viewControllerId: "NotificationViewController", name: "Announcements", imageUrl: "AnnouncementsFilled-50.png")
        self.menuItems.append(notifications)
    }
    
}

//MARK: - UICollectionViewDataSource
extension MasterViewController2 : UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        
        guard let cell = self.collectionView.cellForItemAtIndexPath(indexPath) as? MenuCellCollectionViewCell else {
            return
        }
        
        cell.backgroundColor = ItenWiredStyle.background.color.invertedColor
        cell.nameLabel.textColor = ItenWiredStyle.text.color.invertedColor
        cell.icon.backgroundColor = ItenWiredStyle.background.color.invertedColor
        //cell.icon.setImage(UIImage?, forState: .Normal)
    }
    
    func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        
        guard let cell = self.collectionView.cellForItemAtIndexPath(indexPath) as? MenuCellCollectionViewCell else {
            return
        }
        
        //Changes the colors to main colors
        cell.backgroundColor = ItenWiredStyle.background.color.mainColor
        cell.nameLabel.textColor = ItenWiredStyle.text.color.mainColor
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menuItems.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: (screenBounds.width / 2) - 6, height: 150)
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as? MenuCellCollectionViewCell
        
        cell?.build(self.menuItems[indexPath.row])
        
        cell?.layer.shadowColor = UIColor.blackColor().CGColor
        cell?.layer.shadowOffset = CGSizeMake(0,1.5)
        
        if menuItems[indexPath.row].name == "Announcements"{
            let notificationController = NotificationController()
            cell?.icon.badgeString = ""
            if notificationController.getNumberOfUnReadNotifications() > 0 {
                cell?.icon.badgeString = "\(notificationController.getNumberOfUnReadNotifications())"
            }
        }else {
        
            cell?.icon.badgeString = ""
        }
        
        return cell!
    }
}

//MARK: - UICollectionViewDelegate
extension MasterViewController2: UICollectionViewDelegate{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        
        let index = indexPath.row
        let menuItem = menuItems[index]
        
        if !MasterViewController.isConnectedToNetwork(){
            if menuItem.name == "Live Broadcast"{
                // create the alert
                let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your connected to the internet before accessing \(menuItem.name)", preferredStyle: UIAlertControllerStyle.Alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                
                // show the alert
                self.presentViewController(alert, animated: true, completion: nil)
                
                return
            }
        }
        
        let storyboard = UIStoryboard.init(name: menuItem.storyboardId, bundle: nil)
        let destinationViewController = storyboard.instantiateViewControllerWithIdentifier(menuItem.viewControllerId)
        splitViewController?.showDetailViewController(destinationViewController, sender: nil)
    }
}

//Mark: - UISplitViewControllerDelegate
extension MasterViewController2: UISplitViewControllerDelegate{
    func targetDisplayModeForActionInSplitViewController(svc: UISplitViewController) -> UISplitViewControllerDisplayMode{
        return .PrimaryHidden
    }
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
        return true
    }
}