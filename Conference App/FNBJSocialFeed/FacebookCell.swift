//
//  FacebookCell.swift
//  FNBJSocialFeed
//
//  Created by Felipe on 5/27/16.
//  Copyright © 2016 Academic Technology Center. All rights reserved.
//

import UIKit

class FacebookCell: UITableViewCell {
    
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var postImage: UIImageView!

    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    func build(post: FNBJSocialFeedFacebookPost){
        self.message.text = post.message
        self.name.text = post.fromName
        self.postImage.image = UIImage(named: "placeholder.png")
        self.imageLabel.image = UIImage(named: "placeholder.png")
        
        
        if let profileImageLink = defaults.stringForKey(post.userID) {
            let URL = NSURL(string: profileImageLink)
            self.imageLabel.hnk_setImageFromURL(URL!)
        }else{
            
            let controller = FNBJSocialFeedFacebookController(pageID: "itenwired")
            
            controller.getUserProfile(post.userID, completion: { (user) in
                self.defaults.setObject(user.profilePicture, forKey: post.userID)
                
                let URL = NSURL(string: user.profilePicture)
                self.imageLabel.hnk_setImageFromURL(URL!)
            })
        
        }
        
        if post.type != "link"{
            if let link = defaults.stringForKey(post.object_id){
                let URL = NSURL(string: link)
                self.postImage.hnk_setImageFromURL(URL!)
                
            } else{
                fetchImage(post.object_id)
            }
        }else{
        
            let URL = NSURL(string: post.picture)
            self.postImage.hnk_setImageFromURL(URL!)
        
        }       
        
    }
    
    func fetchImage(object_id: String){
    
        let controller = FNBJSocialFeedFacebookController(pageID: "itenwired")
        
        controller.getPostImage(withObjectId: object_id) { (imageUrl) in
            
            self.defaults.setObject(imageUrl, forKey: object_id)
            let URL = NSURL(string: imageUrl)
            self.postImage.hnk_setImageFromURL(URL!)
        }
    }
}
