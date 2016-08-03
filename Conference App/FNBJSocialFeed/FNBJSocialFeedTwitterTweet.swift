//
//  FNBJSocialFeedTwitterTweet.swift
//  FNBJSocialFeed
//
//  Created by Felipe on 5/31/16.
//  Copyright © 2016 Academic Technology Center. All rights reserved.
//

import Foundation

enum FNBJSocialFeedTwitterTweetEnum : String{
    case text
    case user
    case created_at
    case id_str
    case retweet_count
    case favorite_count
}

class FNBJSocialFeedTwitterTweet{

    /// Tweet's ID
    var id = ""
    
    /// Tweet Body text
    var text = ""
    
    /// Tweet's User
    var user: FNBJSocialFeedTwitterUser!
    
    /// Tweet's posted date
    var date: NSDate!
    
    /// Retweet Count
    var retweetCount = 0
    
    var favoriteCount = 0
    
    init(){
    
    }
    
    
    init(dictionary: NSDictionary){
       
        if let text = dictionary.objectForKey(FNBJSocialFeedTwitterTweetEnum.text.rawValue) as? String{
            self.text = text
        }
    
        if let userData = dictionary.objectForKey(FNBJSocialFeedTwitterTweetEnum.user.rawValue) as? NSDictionary{
            
            let user = FNBJSocialFeedTwitterUser(dictionary: userData)
            
            self.user = user
        }
        
        if let dateString = dictionary.objectForKey(FNBJSocialFeedTwitterTweetEnum.created_at.rawValue) as? String {
        
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss ZZZ yyyy"
            
            self.date = dateFormatter.dateFromString(dateString)
            
        }
        
        if let id = dictionary.objectForKey(FNBJSocialFeedTwitterTweetEnum.id_str.rawValue) as? String{
        
            self.id = id 
        }
        
        if let retweetCount = dictionary.objectForKey(FNBJSocialFeedTwitterTweetEnum.retweet_count.rawValue) as? Int{
            self.retweetCount = retweetCount
        }
        
        if let favoriteCount = dictionary.objectForKey(FNBJSocialFeedTwitterTweetEnum.favorite_count.rawValue) as? Int{
            self.favoriteCount = favoriteCount
        }
        
    }

}