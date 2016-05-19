//
//  MasterViewController.swift
//  Conference App
//
//  Created by B4TH Administrator on 4/1/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit
import CoreData
import SystemConfiguration


class MenuItem{
    var storyboardId:String
    var viewControllerId:String
    var name:String
    var image:UIImage
    
    
    init(storyboardId: String, viewControllerId: String, name: String, imageUrl: String){
        self.storyboardId = storyboardId
        self.viewControllerId = viewControllerId
        self.name = name
        self.image = UIImage(named: imageUrl)!
    }
}

class MasterViewController: UITableViewController, UISplitViewControllerDelegate{
    
    var menuItems:[MenuItem] = []
    
    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    var items: NSMutableArray!
    var images: NSMutableArray!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func targetDisplayModeForActionInSplitViewController(svc: UISplitViewController) -> UISplitViewControllerDisplayMode{
    
        return .PrimaryHidden
    }
    
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        splitViewController?.delegate = self
    
      ///  navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
      //  navigationItem.leftItemsSupplementBackButton = true
  
        
        
        // Tableview delegates
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        
        self.UIConfig()
        
        // Loads menu items into array
        self.loadMenuItems()
    }
    
    internal func UIConfig(){
        
        self.title = "iTen Wired"
        self.tableView = UITableView(frame:self.view!.frame)
        
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView.rowHeight = CGFloat(65.00)
        self.view.backgroundColor = ItenWiredStyle.background.color.mainColor
    }
    
    internal func loadMenuItems(){
        // Loading menu items into array
        let map = MenuItem(storyboardId: "MapView", viewControllerId: "MapStoryboard", name: "Map", imageUrl: "MapM-25.png")
        self.menuItems.append(map)
        
        let agenda = MenuItem(storyboardId: "AgendaMain", viewControllerId: "AgendaInitial", name: "Agenda", imageUrl: "Agenda-25.png")
        self.menuItems.append(agenda)
        
        let myIten = MenuItem(storyboardId: "ItineraryStoryboard", viewControllerId: "Itinerary", name: "My Iten", imageUrl: "MyIten-25.png")
        self.menuItems.append(myIten)
        
        let socialMedia = MenuItem(storyboardId: "SocialMedia", viewControllerId: "SocialMediaRoot", name: "Social Media", imageUrl: "SocialMedia-25.png")
        self.menuItems.append(socialMedia)
        
        let liveBroadcast = MenuItem(storyboardId: "LiveBroadcast", viewControllerId: "LiveBroadcast", name: "Live Broadcast", imageUrl: "LiveBroadcast-25.png")
        self.menuItems.append(liveBroadcast)
        
        let about = MenuItem(storyboardId: "AboutView", viewControllerId: "AboutView", name: "About", imageUrl: "About-25.png")
        self.menuItems.append(about)
        
        let atendees = MenuItem(storyboardId: "Attendees", viewControllerId: "Attendee", name: "Who is here", imageUrl: "Who-25.png")
        self.menuItems.append(atendees)
        
        let notifications = MenuItem(storyboardId: "Notification", viewControllerId: "NotificationViewController", name: "Announcements", imageUrl: "Announcements-25.png")
        self.menuItems.append(notifications)
    }
    
    //Animates view
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
        let index = indexPath.row
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel!.text = menuItems[index].name
        
        if let q : UIImage? = menuItems[index].image{
            cell.imageView?.image = q
        }
        
        cell.backgroundColor = UIColor(red: 0.15, green: 0.353, blue: 0.6, alpha: 0.5)
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        let bgColorView = UIView()
        
        bgColorView.backgroundColor = UIColor.cyanColor()
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    
    /*
     * Voodoo Magic, Don't question it! (from stack overflow)
     * http://stackoverflow.com/users/2303865/leo-dabus : http://stackoverflow.com/questions/30743408/check-for-internet-connection-in-swift-2-ios-9
     */
    
    //FIXME: find better solution
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }

}
