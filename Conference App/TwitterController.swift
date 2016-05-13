//
//  TwitterController.swift
//  Conference App
//
//  Created by Felipe on 5/12/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

class TwitterController{

    let url:String = "http://izotx.com/SocialAPIS/Twitter/"
    let appData = AppData()
    
    func getTweets() -> [Twitter]{
        
        var tweets:[Twitter] = []
        
        let url = NSURL(string: self.url)
        
        if url != nil{
            
            let data = appData.getDataFromURL(url!)
           
            do {
                
                let dictionary =  try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                
                if let twitterData = dictionary["statuses"] as? [NSDictionary]{
                    
                    for tweetData in twitterData{
                        let tweet = Twitter(dictionary: tweetData)
                        tweets.append(tweet)
                    }
                }
                
            }catch {
                print("Error parsing twitter data")
            }
                
            
            
        }
        return tweets
    }
    
}