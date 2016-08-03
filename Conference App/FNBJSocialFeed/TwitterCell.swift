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


//  TwitterCell.swift
//  Agenda1
//
//  Created by Felipe Neves Brito on 5/12/16.


import UIKit
import Haneke

class TwitterCell: UITableViewCell {
    
    var tweet:FNBJSocialFeedTwitterTweet!
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var retweetButton: UIButton!

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var date: UILabel!
  
    
    @IBOutlet weak var userScreenNameLabel: UILabel!
    @IBOutlet weak var profileImageLabel: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    ///Callback function to show the keyboard on the tableview
    var showKeyboard : (feed: FNBJSocialFeedFeedObject, indexPath: NSIndexPath) -> Void = { arg in }
    
    // Cell's actual indexPath on the tableview
    var indexPath = NSIndexPath()
    
    @IBAction func retweetAction(sender: AnyObject) {
        
        let count = self.tweet.retweetCount + 1
        
        self.retweetButton.setTitle("Retweet \(count)", forState: .Normal)
        let twtController = FNBJSocialFeedTwitterController(hashtag: "#itenwired16")
        
        twtController.retweet(self.tweet) { (tweet) in
            
            
        }
        
    }
    
    @IBAction func favoriteAction(sender: AnyObject) {
        let count = self.tweet.favoriteCount + 1
        self.favoriteButton.setTitle("Favourite \(count)", forState: .Normal)
        
        let twtController = FNBJSocialFeedTwitterController(hashtag: "#itenwired16")
        
        twtController.favorite(self.tweet) { 
            
        }
    }
    
    
    @IBAction func replyAction(sender: AnyObject) {
       
        let feed = FNBJSocialFeedFeedObject()
        feed.feed = tweet
        feed.date = tweet.date
        
        self.showKeyboard(feed: feed, indexPath: self.indexPath)
    }
    
    internal func setProfileImage(url:String){
        let urlNS = NSURL(string: url)
        let data = NSData(contentsOfURL: urlNS!)
        self.profileImageLabel.image = UIImage(data: data!)
    }
    
    func build(tweet: FNBJSocialFeedTwitterTweet, indexPath: NSIndexPath, callback: (feed: FNBJSocialFeedFeedObject, indexPath: NSIndexPath)->Void){
        
        self.showKeyboard = callback
        self.indexPath = indexPath
        
        self.tweet = tweet
        
        if self.tweet.retweetCount > 0{
            self.retweetButton.setTitle("Retweet \(self.tweet.retweetCount)", forState: .Normal)
        }else{
            self.retweetButton.setTitle("Retweet", forState: .Normal)
        }
        
        if self.tweet.favoriteCount > 0 {
            self.favoriteButton.setTitle("Favorite \(self.tweet.favoriteCount)", forState: .Normal)
        }else{
            self.favoriteButton.setTitle("Favorite", forState: .Normal)
        }
       
        
        self.tweetText.text = tweet.text
        self.userNameLabel.text = tweet.user.name
        self.userScreenNameLabel.text = "@\(tweet.user.screenName)"
        
        let URL = NSURL(string: tweet.user.profileImage)
        self.profileImageLabel.hnk_setImageFromURL(URL!)
        
        self.profileImageLabel.layer.cornerRadius = self.profileImageLabel.frame.size.width / 4
        self.profileImageLabel.clipsToBounds = true
        
        self.date.text = tweet.date.stringDateSinceNow()
        
        
    }
    
}