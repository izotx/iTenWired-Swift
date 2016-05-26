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


class SocialMediaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let socialData = SocialMediaData()
    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var socialItems:[SocialItem] = [SocialItem(name:"Facebook", logo: "Facebook-50.png", storyboardId: "", viewControllerId: ""),
                                    SocialItem(name:"Twitter", logo: "Twitter-50.png", storyboardId: "SocialMedia", viewControllerId: "TwitterViewController"),
                                    SocialItem(name:"LinkedIn", logo:"LinkedIn-50.png", storyboardId: "", viewControllerId: ""),
                                    SocialItem(name:"Google+", logo :"Google-50.png", storyboardId: "", viewControllerId: ""),
                                    SocialItem(name:"YouTube", logo: "YouTube-50.png", storyboardId: "", viewControllerId: ""),
                                    SocialItem(name:"Instagram", logo: "Instagram-50.png", storyboardId: "", viewControllerId: ""),
                                    SocialItem(name:"Web", logo: "Web-50.png", storyboardId: "", viewControllerId: ""),
                                    SocialItem(name:"Email", logo: "Email-50.png", storyboardId: "", viewControllerId: ""),
                                    SocialItem(name:"Social", logo: "Twitter-50.png", storyboardId: "SocialMedia", viewControllerId: "TwitterViewController")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.UIConfig()
        
        // TableView Delegate
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        shareButton.frame = CGRectMake(160, 100, 50, 50)
        
        shareButton.layer.cornerRadius = 0.75 * shareButton.bounds.size.width
  
    }
    
    internal func UIConfig(){
        self.view.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.tableView.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.shareButton.backgroundColor = ItenWiredStyle.background.color.mainColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SocialMediaCell", forIndexPath: indexPath) as? SocialMediaCell
        
        cell?.build(socialItems[indexPath.row])
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return socialItems.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let socialItem = socialItems[indexPath.row]
        
        if socialItem.name == "Web" {
            
            let urlString = socialData.getSocialMedia("web")?.URL
            
            if let url = NSURL(string: urlString!) {
                UIApplication.sharedApplication().openURL(url)
            }
            return
        }
        
        if socialItem.name == "YouTube" {
            
            let urlString = socialData.getSocialMedia("YouTube")?.URL
            
            if let url = NSURL(string: urlString!) {
                UIApplication.sharedApplication().openURL(url)
            }
            return
        }
        
        if socialItem.name == "Google+" {
            
            let urlString = socialData.getSocialMedia("google")?.URL
            
            if let url = NSURL(string: urlString!) {
                UIApplication.sharedApplication().openURL(url)
            }
            return
        }
        
        if socialItem.name == "Instagram"{
            
            let urlString = socialData.getSocialMedia("Instagram")?.URL
            
            
            // Gets username
            let count = urlString?.componentsSeparatedByString("/").count
            let username = urlString?.componentsSeparatedByString("/")[count!-1]
            let instagramURLString = "instagram://user?username=\(username!)"
            
            let instagramURL = NSURL(string: instagramURLString)
            
            if UIApplication.sharedApplication().canOpenURL(instagramURL!){
                UIApplication.sharedApplication().openURL(instagramURL!)
            } else {
                if let url = NSURL(string: urlString!) {
                    UIApplication.sharedApplication().openURL(url)
                }
            }
            
            
            return
            
        }
        
        if socialItem.name == "LinkedIn" {
            let urlString = socialData.getSocialMedia("linkedin")?.URL
            
            if let url = NSURL(string: urlString!) {
                UIApplication.sharedApplication().openURL(url)
            }
            return
        }
        
        if socialItem.name == "Email" {
            let urlString = socialData.getSocialMedia("email")?.URL
            
            if let url = NSURL(string: "mailto:\(urlString!)") {
                UIApplication.sharedApplication().openURL(url)
            }
            return
        }
        
        if socialItem.name == "Twitter" {
            let urlString = "twitter://search?query=%23iTenWired15"
            let url = NSURL(string: urlString)
            
            if UIApplication.sharedApplication().canOpenURL(url!) {
                UIApplication.sharedApplication().openURL(url!)
            }
            return
        }
        
        if socialItem.name == "Facebook" {
            
            
            let urlString = socialData.getSocialMedia("facebook")?.URL
            
            
            // Gets username
            let count = urlString?.componentsSeparatedByString("/").count
            let username = urlString?.componentsSeparatedByString("/")[count!-1]
            let fbURLString = "fb://\(username!)"
            
            let fbURL = NSURL(string: fbURLString)
            
            if UIApplication.sharedApplication().canOpenURL(fbURL!){
                UIApplication.sharedApplication().openURL(fbURL!)
            } else {
                if let url = NSURL(string: urlString!) {
                    UIApplication.sharedApplication().openURL(url)
                }
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
    
    
   
    func displayShareSheet(button: AnyObject, shareContent:String) {
        
        
        if let splitController = self.splitViewController{
            
            if !splitController.collapsed {
                let vc = UIActivityViewController(activityItems: [shareContent as NSString], applicationActivities: nil)
//                var barButtonItem: UIBarButtonItem! = UIBarButtonItem()
                vc.popoverPresentationController?.sourceRect = (button as! UIView).frame
                vc.popoverPresentationController?.sourceView = self.view
               // vc.popoverPresentationController?.arrowDirection = .Default
                self.presentViewController(vc, animated: true, completion: nil)
                
            } else{
                let activityViewController = UIActivityViewController(activityItems: [shareContent as NSString], applicationActivities: nil)
                presentViewController(activityViewController, animated: true, completion: {})
            }
        }
        
        
        
        
    }
    
    @IBAction func shareButtonAction(sender: AnyObject) {
        
        let hashtags = self.socialData.getHashTags()
        
        var content = ""
        
        for hashtag in hashtags{
            content = "\(hashtag) \(content)"
        }
        displayShareSheet(sender, shareContent:content)
    }
    
}
