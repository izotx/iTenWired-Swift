//
//  EventCell.swift
//  Agenda1
//
//  Created by Felipe Neves Brito on 5/12/16.
//  Copyright © 2016 Felipe Neves Brito. All rights reserved.
//

import UIKit

class TwitterCell: UITableViewCell {

    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userScreenNameLabel: UILabel!
    @IBOutlet weak var profileImageLabel: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    func build(tweet:Twitter){
        self.tweetLabel.text = tweet.text
        self.userNameLabel.text = tweet.user.name
        self.userScreenNameLabel.text = "@\(tweet.user.screenName)"
    }
    
    internal func setProfileImage(url:String){
        let urlNS = NSURL(string: url)
        let data = NSData(contentsOfURL: urlNS!)
        self.profileImageLabel.image = UIImage(data: data!)
    }
    
    func setProfileImage(photoRecord: Photorecord){
        self.profileImageLabel.image = photoRecord.image!
    }
    
}