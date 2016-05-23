//
//  MasterViewController2.swift
//  Conference App
//
//  Created by Felipe on 5/18/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController2 : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISplitViewControllerDelegate {
    
    let screenBounds = UIScreen.mainScreen().bounds
    var menuItems:[MenuItem] = []
    let reach = Reach()
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
        
        
        loadMenuItems()
        
        self.UIConfig()
        
        //CollectionView Deleagte
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // SplitView Delegate
        splitViewController?.delegate = self
        
        self.logo.image = UIImage(named: "logo.png")
        
        if reach.connectionStatus().description != "Offline"{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
        
                let aboutData = AboutData()
                let about = aboutData.getAbout()
            
                let url = NSURL(string: about.image)
                let data = NSData(contentsOfURL: url!)
                self.logo.image = UIImage(data: data!)
            }
        }
        
    }
    
    internal func UIConfig(){
        self.collectionView.backgroundColor = ItenWiredStyle.background.color.invertedColor
    }
    
    func targetDisplayModeForActionInSplitViewController(svc: UISplitViewController) -> UISplitViewControllerDisplayMode{
        
        return .PrimaryHidden
    }
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        
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
        
        
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
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
    
    internal func loadMenuItems(){
        // Loading menu items into array
        let map = MenuItem(storyboardId: "MapView", viewControllerId: "MapStoryboard", name: "Map", imageUrl: "MapM-50.png")
        self.menuItems.append(map)
        
        let agenda = MenuItem(storyboardId: "AgendaMain", viewControllerId: "AgendaInitial", name: "Agenda", imageUrl: "Agenda-50.png")
        self.menuItems.append(agenda)
        
        let myIten = MenuItem(storyboardId: "ItineraryStoryboard", viewControllerId: "Itinerary", name: "My Iten", imageUrl: "MyIten-50.png")
        self.menuItems.append(myIten)
        
        let socialMedia = MenuItem(storyboardId: "SocialMedia", viewControllerId: "SocialMediaRoot", name: "Social Media", imageUrl: "SocialMedia-50.png")
        self.menuItems.append(socialMedia)
        
        let liveBroadcast = MenuItem(storyboardId: "LiveBroadcast", viewControllerId: "LiveBroadcast", name: "Live Broadcast", imageUrl: "LiveBroadcast-50.png")
        self.menuItems.append(liveBroadcast)
        
        let about = MenuItem(storyboardId: "AboutView", viewControllerId: "AboutView", name: "About", imageUrl: "About-50.png")
        self.menuItems.append(about)
        
        let atendees = MenuItem(storyboardId: "Attendees", viewControllerId: "Attendee", name: "Who is here", imageUrl: "Who-50.png")
        self.menuItems.append(atendees)
        
        let notifications = MenuItem(storyboardId: "Notification", viewControllerId: "NotificationViewController", name: "Announcements", imageUrl: "Announcements-50.png")
        self.menuItems.append(notifications)
    }
    
}