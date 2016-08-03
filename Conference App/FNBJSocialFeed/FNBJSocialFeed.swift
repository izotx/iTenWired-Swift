//Copyright (c) 2016, Academic Technology Center
//All rights reserved.
//
//Redistribution and use in source and binary forms, with or without
//modification, are permitted provided that the following conditions are met:
//
//* Redistributions of source code must retain the above copyright notice, this
//list of conditions and the following disclaimer.
//
//* Redistributions in binary form must reproduce the above copyright notice,
//this list of conditions and the following disclaimer in the documentation
//and/or other materials provided with the distribution.
//
//* Neither the name of FNBJSocialFeed nor the names of its
//contributors may be used to endorse or promote products derived from
//this software without specific prior written permission.
//
//THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
//FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
//DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
//CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
//OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
//OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

//
//  FNBJSocialFeed.swift
//  FNBJSocialFeed
//
//  Created by Felipe Brito {felipenevesbrito@gmail.com} on 5/31/16.
//  Copyright © 2016 Academic Technology Center. All rights reserved.
//

import UIKit

enum FNBJSocialFeedSocialTokenEnum : String{
    case fb
    case twt
}

class FNBJSocialFeed{
    
    /// The facebook's page ID
    var facebookPageID: String = ""
    
    /// The Twitter's hashtag
    var twitterHashtag: String = ""
    
    /// Facebook Controller
    let fbController : FNBJSocialFeedFacebookController!
    
    /// Twitter Controller
    let twtController : FNBJSocialFeedTwitterController!
    
    /// NSUserDefaults instance for storing informations
    let defaults = NSUserDefaults.standardUserDefaults()
    
    /// Stores the paging tokens for the social medias 
    var pagingTokens = [FNBJSocialFeedSocialTokenEnum.fb.rawValue : "", FNBJSocialFeedSocialTokenEnum.twt.rawValue : ""]
    
    /// Facebook downloaded feed
    var facebookFeed : [FNBJSocialFeedFacebookPost] = []
    
    /// Twitter Downloaded Feed
    var twitterFeed : [FNBJSocialFeedTwitterTweet] = []
    
    
    /**
        Initiates the FNBJSocialFeed Controller 
     
        - Parameters:
            - facebookPageID: The facebook's page ID ex: for facebook.com/itenwired the id is itenwired
            - twitterHashtag: The Twitter's hashtag
     
    */
    init(facebookPageID: String, twitterHashtag: String){
        self.facebookPageID = facebookPageID
        self.twitterHashtag = twitterHashtag
        
        self.fbController = FNBJSocialFeedFacebookController(pageID: facebookPageID)
        self.twtController = FNBJSocialFeedTwitterController(hashtag: twitterHashtag)
    }
    
    
    /**
        Gets the feed from facebook and twitter
     
            - Parameter: completion: A handler which is called when the function finishes loading the feed from both facebook and twitter. It will load the variable feed with all the content
    */
    func getFeed(completion: (feed: [FNBJSocialFeedFeedObject]) -> Void){
        
        var fbIsDone = false
        var twtIsDone = false
        
        var feed: [FNBJSocialFeedFeedObject] = []
    
        fbController.getPublicPageSocialFeed(withPageId: facebookPageID) { (posts, pagingToken) in
            
            for post in posts{
                
                self.facebookFeed.append(post)
                
                let f = FNBJSocialFeedFeedObject()
                
                f.feed = post
                f.date = post.created_time
                feed.append(f)
            }
            
            self.pagingTokens[FNBJSocialFeedSocialTokenEnum.fb.rawValue] = pagingToken
            fbIsDone = true
            
            if fbIsDone && twtIsDone {
                completion(feed: feed)
            }
        }
        
        twtController.getPublicPageSocialFeed(twitterHashtag) { (tweets, paging) in
            
            for tweet in tweets{
                
                self.twitterFeed.append(tweet)
                
                let t = FNBJSocialFeedFeedObject()
                t.feed = tweet
                t.date = tweet.date
                feed.append(t)
            }
            
            self.pagingTokens[FNBJSocialFeedSocialTokenEnum.twt.rawValue] = paging
            twtIsDone = true
            
            if fbIsDone && twtIsDone {
                completion(feed: feed)
            }
        }
    }
    
    func hasViewPermissions() -> Bool{
        let fb = fbController.hasViewPermission()
        return fb
    }
    
    func loginWithReadPermissions(vc: UIViewController, completion: () -> Void){
    
        fbController.loginWithReadPermissions([FNBJSocialFeedFacebookPermissionsEnum.public_profile], fromViewController: vc) { (token) in
            completion()
        }
    }
    
    func getFeedPaging(completion: (feed: [FNBJSocialFeedFeedObject]) -> Void){
       
        var feed : [FNBJSocialFeedFeedObject] = []
        
        var fb = false
        var twt = false
        
        fbController.getPublicPageSocialFeedPaging(self.pagingTokens["fb"]!) { (posts, nextToken) in
            for post in posts{
            
                let f = FNBJSocialFeedFeedObject()
                f.feed = post
                f.date = post.created_time
                feed.append(f)
            }
            
            self.pagingTokens[FNBJSocialFeedSocialTokenEnum.fb.rawValue] = nextToken
            fb = true
            
            if fb && twt {
                completion(feed: feed)
            }
        }
        
        if self.pagingTokens[FNBJSocialFeedSocialTokenEnum.twt.rawValue] == ""{
            twt = true
            
            if fb && twt {
                completion(feed: feed)
            }
        }else{
            
            twtController.getPublicPageSocialFeed(withPagin: self.pagingTokens["twt"]!) { (tweets, paging) in
            
                for tweet in tweets{
                
                    let t = FNBJSocialFeedFeedObject()
                    t.feed = tweet
                    t.date = tweet.date
                    feed.append(t)
                }
            
                self.pagingTokens["twt"] = paging
                twt = true
            
                if fb && twt {
                    completion(feed: feed)
                }
            }
        }  
    }
    
    func checkForNewFeed(completion: (hasNewFeed: Bool) ->Void){
        
        var fbIsDone = false
        var twtIsDone = false
        
        fbController.checkForNewPosts(self.facebookFeed) { (hasNewPosts) in
            fbIsDone = true
            
            if fbIsDone && twtIsDone{
                completion(hasNewFeed: hasNewPosts)
            }
        }
        
        twtController.checkForNewTweets(self.twitterFeed) { (hasNewTweets) in
            twtIsDone = true
            
            if fbIsDone && twtIsDone{
                completion(hasNewFeed: hasNewTweets)
            }
        }
    }
    
    func replyToTweet(tweet: FNBJSocialFeedTwitterTweet, inReplyTo: FNBJSocialFeedTwitterTweet){
        self.twtController.reply(tweet, inReplyTo: inReplyTo)
    }
}

