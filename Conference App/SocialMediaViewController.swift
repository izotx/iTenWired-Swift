//
//  SociaMedia.swift
//  Conference App
//
//  Created by Felipe Neves on 5/16/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit

class SocialItem {
    var name:String = ""
    var logo:String = ""
    var storyboardId = ""
    var viewControllerId = ""
    
    init(name:String, logo:String, storyboardId:String, viewControllerId: String){
        self.name = name
        self.logo = logo
        self.storyboardId = storyboardId
        self.viewControllerId = viewControllerId
    }
}


class SocialMediaViewController: UITableViewController {
    
    var socialItems:[SocialItem] = [SocialItem(name:"Facebook", logo: "facebook.png", storyboardId: "", viewControllerId: ""),
                                    SocialItem(name:"Twitter", logo: "twitter.png", storyboardId: "SocialMedia", viewControllerId: "TwitterViewController"),
                                    SocialItem(name:"YouTube", logo: "youtube.png", storyboardId: "", viewControllerId: ""),
                                    SocialItem(name:"Instagram", logo: "instagram-50-2.png", storyboardId: "", viewControllerId: ""),
                                    SocialItem(name:"Web", logo: "web.png", storyboardId: "", viewControllerId: ""),
                                    SocialItem(name:"Email", logo: "email.png", storyboardId: "", viewControllerId: "")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("socialSelectCells", forIndexPath: indexPath)
        
        cell.textLabel?.text = socialItems[indexPath.row].name
        cell.imageView?.image = UIImage(named: socialItems[indexPath.row].logo)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return socialItems.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let socialItem = socialItems[indexPath.row]
        
        if socialItem.name == "Web" {
            if let url = NSURL(string: "http://www.itenwired.com") {
                UIApplication.sharedApplication().openURL(url)
            }
            return
        }
        
        //TODO: Finish social item ids
        if socialItem.storyboardId != ""{
            
            let storyboard = UIStoryboard.init(name: socialItem.storyboardId, bundle: nil)
            let destinationViewController = storyboard.instantiateViewControllerWithIdentifier(socialItem.viewControllerId)
            splitViewController?.showDetailViewController(destinationViewController, sender: nil)
        }
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
