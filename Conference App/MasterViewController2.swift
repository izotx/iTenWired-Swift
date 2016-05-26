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
    
   // var screenBounds = UIScreen.mainScreen().bounds
    var menuItems:[MenuItem] = []
    let reach = Reach()
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    
    override func viewWillAppear(animated: Bool) {
      //  screenBounds = UIScreen.mainScreen().bounds
          print(collectionView.frame.size)
        self.collectionView.reloadData()
        
        self.navigationController?.navigationBarHidden = true
//        self.navigationController?.navigationBar.barTintColor = ItenWiredStyle.background.color.mainColor
        
//        let titleDict: [String : AnyObject] = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
//        // Transparent navigation bar
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.translucent = true
//        
//        self.navigationController?.navigationBar.titleTextAttributes = titleDict
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UITabBar.appearance().tintColor = ItenWiredStyle.background.color.mainColor
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: NSSelectorFromString("updateData"), name: NotificationObserver.APPBecameActive.rawValue, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: NSSelectorFromString("updateData"), name: NotificationObserver.RemoteNotificationReceived.rawValue, object: nil)
        
        loadMenuItems()
        self.UIConfig()
        
        
        //CollectionView Deleagte
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // SplitView Delegate
        splitViewController?.delegate = self
    }
    
    
    override func viewWillDisappear(animated: Bool) {
         self.navigationController?.navigationBarHidden = false
    }
    
    func updateData(){
        self.collectionView.reloadData()
    }
    
    internal func UIConfig(){
        self.collectionView.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.view.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.logo.image = UIImage(named: "logo-16.png")
        self.navigationController?.navigationBarHidden = true 
        
    }
    
    /**
        Loads the menu items into the MenuItems array
    */
    internal func loadMenuItems(){
  
        
        let agenda = MenuItem(storyboardId: "AgendaMain", viewControllerId: "AgendaInitial", name: "Agenda", imageUrl: "AgendaFilled-50.png")
        self.menuItems.append(agenda)
        
        let atendees = MenuItem(storyboardId: "Attendees", viewControllerId: "Attendee", name: "Who is here", imageUrl: "WhoFilled-50.png")
        self.menuItems.append(atendees)
        
        let myIten = MenuItem(storyboardId: "ItineraryStoryboard", viewControllerId: "Itinerary", name: "My Iten", imageUrl: "MyItenFilled-50.png")
        self.menuItems.append(myIten)
        
        let notifications = MenuItem(storyboardId: "Notification", viewControllerId: "NotificationViewControllerNav", name: "Announcements", imageUrl: "AnnouncementsFilled-50.png")
        self.menuItems.append(notifications)

        let map = MenuItem(storyboardId: "MapView", viewControllerId: "MapNavStoryboard", name: "Map", imageUrl: "MapMFilled-50.png")
        self.menuItems.append(map)
        
        let socialMedia = MenuItem(storyboardId: "SocialMedia", viewControllerId: "SocialMediaNav", name: "Social Media", imageUrl: "SocialMediaFilled-50.png")
        self.menuItems.append(socialMedia)
        
//        let liveBroadcast = MenuItem(storyboardId: "LiveBroadcast", viewControllerId: "LiveBroadcastNav", name: "Live Broadcast", imageUrl: "LiveBroadcastFilled-50.png")
//        self.menuItems.append(liveBroadcast)
        
        let about = MenuItem(storyboardId: "AboutView", viewControllerId: "AboutViewNav", name: "About", imageUrl: "AboutFilled-50.png")
        self.menuItems.append(about)
        
   
        
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
        cell.icon.setImage(menuItems[indexPath.row].invertedColorIcon, forState: .Normal)
    }
    
    func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        
        guard let cell = self.collectionView.cellForItemAtIndexPath(indexPath) as? MenuCellCollectionViewCell else {
            return
        }
        
        cell.backgroundColor = ItenWiredStyle.background.color.mainColor
        cell.nameLabel.textColor = ItenWiredStyle.text.color.mainColor
        cell.icon.backgroundColor = ItenWiredStyle.background.color.mainColor
        cell.icon.setImage(menuItems[indexPath.row].image, forState: .Normal)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menuItems.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        print(collectionView.frame.size)
        if let svc = self.splitViewController where svc.collapsed == false  {
            return CGSize(width: ((collectionView.frame.size.width - 10)) , height: 60)
        }
        
        return CGSize(width: ((collectionView.frame.size.width - 10) / 2)  - 6 , height: 150)
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        
        if let svc = self.splitViewController where svc.collapsed == false  {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCellLong", forIndexPath: indexPath) as? MenuCellCollectionViewCell
            
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
//        
//        guard let cell = self.collectionView.cellForItemAtIndexPath(indexPath) as? MenuCellCollectionViewCell else {
//            return
//        }
//        
//        cell.backgroundColor = ItenWiredStyle.background.color.invertedColor
//        cell.nameLabel.textColor = ItenWiredStyle.text.color.invertedColor
//        cell.icon.backgroundColor = ItenWiredStyle.background.color.invertedColor
//        cell.icon.setImage(menuItems[indexPath.row].invertedColorIcon, forState: .Normal)
        
        let index = indexPath.row
        let menuItem = menuItems[index]
        
        if !NetworkConnection.isConnected() {
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
        
        if menuItem.name == "Announcements"{
            self.collectionView.reloadData()
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