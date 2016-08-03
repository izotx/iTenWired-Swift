//
//  FacebookCell.swift
//  FNBJSocialFeed
//
//  Created by Felipe on 5/27/16.
//  Copyright © 2016 Academic Technology Center. All rights reserved.
//

import UIKit

class FNBJSocialFeedFacebookCellTextOnly : UITableViewCell {
    
    

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var message: UILabel!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    func build(post: FNBJSocialFeedFacebookPost){
        self.message.text = post.message
        self.name.text = post.fromName
        
        if let profileImageLink = defaults.stringForKey(post.userID) {
            let URL = NSURL(string: profileImageLink)
            self.profileImage.hnk_setImageFromURL(URL!)
        }else{
            
            let controller = FNBJSocialFeedFacebookController(pageID: "itenwired")
            
            controller.getUserProfile(post.userID, completion: { (user) in
                print(user.profilePicture)
                
                self.defaults.setObject(user.profilePicture, forKey: post.userID)
                
                let URL = NSURL(string: user.profilePicture)
                self.profileImage.hnk_setImageFromURL(URL!)
            })
            
        }
    }
    
}
