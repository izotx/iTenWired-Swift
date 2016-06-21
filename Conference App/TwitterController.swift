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

//  TwitterController.swift
//  Conference App
//
//  Created by Felipe on 5/12/16.


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