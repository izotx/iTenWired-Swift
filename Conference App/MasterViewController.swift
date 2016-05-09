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

public var Vc:[UIViewController] = [/*UINavigationController(),*/UIViewController(),UIViewController(),UIViewController(),UIViewController(),UIViewController(),UIViewController(),UIViewController(),UIViewController()]
class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    //initialize String for Menu List
    let x:[String] = [/*"Home",*/"Map","Agenda","My Iten","Social Media","Live Broadcast","About","Who is Here", "Settings"]
    //assigns images to menu listß
    let m:[UIImage] = [/*UIImage(named:"Home.png")!,*/UIImage(named:"Map.png")!,UIImage(named:"Agenda.png")!,UIImage(named:"MyIten.png")!,UIImage(named:"SocialMedia.png")!,UIImage(named:"LiveBroadcast.png")!,UIImage(named:"About.png")!,UIImage(named:"Who.png")!,UIImage(named:"Settings.png")!]
    
    
    //creates new default instances of UIViewController to initialize storyboards
    
    
    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    var items: NSMutableArray!
    var images: NSMutableArray!

    //Entry Function
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = NSMutableArray(array: x)
        self.images = NSMutableArray(array: m)
        self.title = "iTen Wired"
        self.tableView = UITableView(frame:self.view!.frame)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.rowHeight = CGFloat(65.00)
        self.view.backgroundColor = UIColor(red: 0.15, green: 0.353, blue: 0.6, alpha: 100)
        
        //Intitializes and Adds new view controllers to Menu
        Vc[0].addChildViewController(UIViewController())
        Vc[0].navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Plain, target: self.view, action: nil)
        
        
        //Adds new initialized ViewControllers to a ViewController array
        var Sbd:UIStoryboard? = UIStoryboard.init(name: "MapView", bundle: nil)
        var dViewController:UIViewController = Sbd!.instantiateViewControllerWithIdentifier("MapStoryboard")
        Vc[0] = dViewController
        
        /*Sbd = UIStoryboard.init(name: "MapView", bundle: nil)
        dViewController = Sbd!.instantiateViewControllerWithIdentifier("MapStoryboard")
        Vc[0] = dViewController*/
        
        Sbd = UIStoryboard.init(name: "AgendaMain", bundle: nil)
        dViewController = Sbd!.instantiateViewControllerWithIdentifier("AgendaInitial")
        Vc[1] = dViewController
        
        Sbd = UIStoryboard.init(name: "ItineraryStoryboard", bundle: nil)
        dViewController = Sbd!.instantiateViewControllerWithIdentifier("Itinerary")
        Vc[2] = dViewController
        
        Sbd = UIStoryboard.init(name: "SocialMedia", bundle: nil)
        dViewController = Sbd!.instantiateViewControllerWithIdentifier("SocialMedia")
        Vc[3] = dViewController
        
        Sbd = UIStoryboard.init(name: "LiveBroadcast", bundle:nil)
        dViewController = Sbd!.instantiateViewControllerWithIdentifier("LiveBroadcast")
        Vc[4] = dViewController
        
        Sbd = UIStoryboard.init(name: "AboutView", bundle: nil)
        dViewController = Sbd!.instantiateViewControllerWithIdentifier("AboutView")
        Vc[5] = dViewController
        
        Sbd = UIStoryboard.init(name: "Attendees", bundle: nil)
        dViewController = Sbd!.instantiateViewControllerWithIdentifier("Attendee")
        Vc[6] = dViewController
        
        /*Sbd = UIStoryboard.init(name: "Home", bundle: nil)
        dViewController = Sbd!.instantiateViewControllerWithIdentifier("Home")
        Vc[0] = dViewController*/
     
    }
    //Animates view
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    //Memory Issues Function (UNUSED)
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
            //let object = self.fetchedResultsController.objectAtIndexPath(indexPath)
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                //controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }*/
    
    //What happens when you push a button
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let view = Vc[indexPath.row]
        if view is UITableViewController{
            let tv = view.view as! UITableView
            tv.reloadData()
        }
        
        if !MasterViewController.isConnectedToNetwork() {
            print(x)
            print("\(indexPath.row) \(x.count)")
            if x[indexPath.row] == "Map" || x[indexPath.row] == "Social Media" || x[indexPath.row] == "Live Broadcast" || x[indexPath.row] == "About" || x[indexPath.row] == "Who is Here"{
                
                print("Network not found")
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                
                let pop:UIAlertController = UIAlertController(title: "No Network!", message: "This Item Is Unavailable Offline!", preferredStyle: UIAlertControllerStyle.Alert)
                
                pop.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
               
                self.presentViewController(pop, animated: true, completion: nil)//viewControllerElement)
                
                            }
            else{
              
                if let m = view.navigationController{
                    m.navigationItem.setHidesBackButton(false, animated: true)
                    m.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
                    m.navigationItem.hidesBackButton = false
                    m.navigationItem.leftBarButtonItem = m.navigationItem.backBarButtonItem
                    m.navigationBarHidden = false
                }
                if let q = self.detailViewController{
                    q.navigationItem.setHidesBackButton(false, animated: true)
                    q.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
                    q.navigationItem.hidesBackButton = false
                    q.navigationItem.leftBarButtonItem = q.navigationItem.backBarButtonItem
                    //q.navigationBarHidden = false
                
                }
               /*let f = UINavigationController(rootViewController: self)
                
                f.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
                f.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
                f.title = "iTen Wired"
                //f.view = view.view*/
                self.showDetailViewController(view, sender: self)
            }
        }
        else {
          
            if let m = view.navigationController{
                m.navigationItem.setHidesBackButton(false, animated: true)
                //m.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
                m.navigationItem.hidesBackButton = false
                //m.navigationItem.leftBarButtonItem = m.navigationItem.backBarButtonItem
                //m.navigationBarHidden = false
                
            }

            if let q = self.detailViewController{
                q.navigationItem.setHidesBackButton(false, animated: true)
                //q.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
                q.navigationItem.hidesBackButton = false
                //q.navigationItem.leftBarButtonItem = q.navigationItem.backBarButtonItem
                //q.navigationBarHidden = false
                
            }
            /*let f = UINavigationController(rootViewController: self)
            
            f.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
            f.title = "iTen Wired"
*/
            self.showDetailViewController(view, sender: self)
            
        }
        
                
        
        
        
    }
    // MARK: - Table View

    /*override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //return self.fetchedResultsController.sections?.count ?? 0
    }*/
    
    //Number of Selectable Rows
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects*/
        
        return self.items.count;
    }
    //Add Cells To Table View
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        /*let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        self.configureCell(cell, withObject: object)
        return cell*/
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = "\(self.items[indexPath.row])"
        if let q:UIImage? = self.images[indexPath.row] as? UIImage{
            cell.imageView?.image = q
        }
        cell.backgroundColor = UIColor(red: 0.15, green: 0.353, blue: 0.6, alpha: 0.5)
        //cell.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.75, alpha: 0.5)
        cell.textLabel?.textColor = UIColor(red: 1, green: 0.63, blue: 0, alpha: 100)
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.cyanColor()
        cell.selectedBackgroundView = bgColorView
        //cell.setValue(UIView(), forKeyPath: "Home")
        /*if !MasterViewController.isConnectedToNetwork() {
            if cell.textLabel!.text == "Map" {
                cell.userInteractionEnabled = false
            }
            else if cell.textLabel!.text == "Social Media" {
                cell.userInteractionEnabled = false
            }
        }
        else {
            if cell.textLabel!.text == "Map" {
                cell.userInteractionEnabled = true
            }
            else if cell.textLabel!.text == "Social Media" {
                cell.userInteractionEnabled = true
            }
        }*/
        return cell
    }
    
    /*
     * Voodoo Magic, Don't question it! (from stack overflow)
     * http://stackoverflow.com/users/2303865/leo-dabus : http://stackoverflow.com/questions/30743408/check-for-internet-connection-in-swift-2-ios-9
     */
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
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        //return true
        return false
    }
}


/*
func insertNewObject(Name: String, Content: UIViewController) {
    /* Default Code
     let context = self.fetchedResultsController.managedObjectContext
     let entity = self.fetchedResultsController.fetchRequest.entity!
     let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context)
     
     // If appropriate, configure the new managed object.
     // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
     newManagedObject.setValue(NSDate(), forKey: "timeStamp")
     
     // Save the context.
     do {
     try context.save()
     } catch {
     // Replace this implementation with code to handle the error appropriately.
     // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
     //print("Unresolved error \(error), \(error.userInfo)")
     abort()
     }
     */
}
*/

