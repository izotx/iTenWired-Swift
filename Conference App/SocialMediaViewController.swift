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

//  SociaMedia.swift
//  Conference App
//
//  Created by Felipe Neves on 5/16/16.

import UIKit

class SocialItem {
    
    /// Social Media Name
    var name:String = ""
    
    /// Social Media icon path
    var logo:String = ""
    
    /// The Social Media Storyboard ID
    var storyboardId = ""
    
    /// The Social Media's ViewController ID
    var viewControllerId = ""
    
    init(name:String, logo:String, storyboardId:String, viewControllerId: String){
        self.name = name
        self.logo = logo
        self.storyboardId = storyboardId
        self.viewControllerId = viewControllerId
    }
}


class SocialMediaViewController: UIViewController{
    
    let socialData = SocialMediaData()
    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var socialItems:[SocialItem] = [
                                    SocialItem(name: "iTenWired Social Feed", logo: "iTenWiredFeed-50.png", storyboardId:                  "SocialMedia", viewControllerId: "ITENFEEDSTORYBOARD"),
                                    SocialItem(name:"Facebook", logo: "Facebook-50.png", storyboardId: "", viewControllerId: ""),
                                    SocialItem(name:"Twitter", logo: "Twitter-50.png", storyboardId: "SocialMedia", viewControllerId: "TwitterViewController"),
                                    SocialItem(name:"LinkedIn", logo:"LinkedIn-50.png", storyboardId: "", viewControllerId: ""),
                                    SocialItem(name:"Google+", logo :"Google-50.png", storyboardId: "", viewControllerId: ""),
                                    SocialItem(name:"YouTube", logo: "YouTube-50.png", storyboardId: "", viewControllerId: ""),
                                    SocialItem(name:"Instagram", logo: "Instagram-50.png", storyboardId: "", viewControllerId: ""),
                                    SocialItem(name:"Web", logo: "Web-50.png", storyboardId: "", viewControllerId: ""),
                                    SocialItem(name:"Email", logo: "Email-50.png", storyboardId: "", viewControllerId: "")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIConfig()
        
        // TableView Delegate
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    internal func UIConfig(){
        self.view.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.tableView.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.shareButton.backgroundColor = ItenWiredStyle.background.color.mainColor
        
        shareButton.frame = CGRectMake(160, 100, 50, 50)
        shareButton.layer.cornerRadius = 0.75 * shareButton.bounds.size.width
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
                vc.popoverPresentationController?.sourceRect = (button as! UIView).frame
                vc.popoverPresentationController?.sourceView = self.view
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

//MARK:  UITableViewDelegate, UITableViewDataSource
extension SocialMediaViewController: UITableViewDelegate, UITableViewDataSource {

    
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
            
            if let socialMedia = socialData.getSocialMedia("web") {
            
                let urlString = socialMedia.URL
            
                if let url = NSURL(string: urlString) {
                    UIApplication.sharedApplication().openURL(url)
                }
                return
            }
            return
        }
        
        if socialItem.name == "YouTube" {
            
            if let socialMedia = socialData.getSocialMedia("YouTube"){
            
                let urlString = socialMedia.URL
            
                if let url = NSURL(string: urlString) {
                    UIApplication.sharedApplication().openURL(url)
                }
                return
            }
            return
        }
        
        if socialItem.name == "Google+" {
            
            if let socialMedia = socialData.getSocialMedia("google"){
            
                let urlString = socialMedia.URL
                
                if let url = NSURL(string: urlString) {
                    UIApplication.sharedApplication().openURL(url)
                }
                return
            }
            return
        }
        
        if socialItem.name == "Instagram"{
            
            if let socialMedia = socialData.getSocialMedia("Instagram"){
            
                let urlString = socialMedia.URL
            
                // Gets username
                let count = urlString.componentsSeparatedByString("/").count
                let username = urlString.componentsSeparatedByString("/")[count-1]
                let instagramURLString = "instagram://user?username=\(username)"
            
                let instagramURL = NSURL(string: instagramURLString)
            
                if UIApplication.sharedApplication().canOpenURL(instagramURL!){
                    UIApplication.sharedApplication().openURL(instagramURL!)
                } else {
                    if let url = NSURL(string: urlString) {
                    UIApplication.sharedApplication().openURL(url)
                    }
                }
                return
            }
            return
        }
        
        if socialItem.name == "LinkedIn" {
            
            if let socialMedia = socialData.getSocialMedia("linkedin"){
            
                let urlString = socialMedia.URL
            
                if let url = NSURL(string: urlString) {
                    UIApplication.sharedApplication().openURL(url)
                }
                return
            }
            return
        }
        
        if socialItem.name == "Email" {
            
            if let socialMedia = socialData.getSocialMedia("email"){
            
                let urlString = socialMedia.URL
            
                if let url = NSURL(string: "mailto:\(urlString)") {
                    UIApplication.sharedApplication().openURL(url)
                }
                return
            }
            return
        }
        
        if socialItem.name == "Twitter" {
            
            let urlString = "twitter://search?query=%23iTenWired16"
            let url = NSURL(string: urlString)
            
            if UIApplication.sharedApplication().canOpenURL(url!) {
                UIApplication.sharedApplication().openURL(url!)
            }else {
                if let url = NSURL(string: urlString) {
                    UIApplication.sharedApplication().openURL(url)
                }
            }
            return
        }
        
        if socialItem.name == "Facebook" {
            
            if let socialMedia = socialData.getSocialMedia("facebook"){
            
                let urlString = socialMedia.URL
                
                // Gets username
                let count = urlString.componentsSeparatedByString("/").count
                let username = urlString.componentsSeparatedByString("/")[count-1]
                let fbURLString = "fb://\(username)"
            
                let fbURL = NSURL(string: fbURLString)
            
                if UIApplication.sharedApplication().canOpenURL(fbURL!){
                    UIApplication.sharedApplication().openURL(fbURL!)
                } else {
                    if let url = NSURL(string: urlString) {
                        UIApplication.sharedApplication().openURL(url)
                    }
                }
                return
            }
            return 
        }
        
        if socialItem.storyboardId != ""{
            
            let storyboard = UIStoryboard.init(name: socialItem.storyboardId, bundle: nil)
            let destinationViewController = storyboard.instantiateViewControllerWithIdentifier(socialItem.viewControllerId)
            splitViewController?.showDetailViewController(destinationViewController, sender: nil)
        }
    }
}
