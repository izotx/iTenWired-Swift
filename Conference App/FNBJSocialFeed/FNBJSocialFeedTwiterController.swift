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
//  FNBJSocialFeedTwiterController.swift
//  FNBJSocialFeed
//
//  Created by Felipe Brito on 5/31/16.
//  Copyright © 2016 Academic Technology Center. All rights reserved.
//

import Foundation
import TwitterKit


class FNBJSocialFeedTwitterController{
    
    let client = TWTRAPIClient()
    var hashtag = ""
    
    init(hashtag: String){
        self.hashtag = hashtag
    }
    
    func favorite(tweet: FNBJSocialFeedTwitterTweet, completion: () -> Void){
        
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
            
            let client = TWTRAPIClient(userID: userID)
            
            let url = "https://api.twitter.com/1.1/favorites/create.json?id=\(tweet.id)"
            let params = ["id": tweet.id]
            var clientError: NSError?
            
            let request = client.URLRequestWithMethod("POST", URL: url, parameters: params, error: &clientError)
            
            client.sendTwitterRequest(request) { (res, data, err) in
                if let e = err {
                    print(e)
                }else if let data = data{
                    
                }
            }
            
        }else{
            
            print("error")
        }
    }
    
    func retweet(tweet: FNBJSocialFeedTwitterTweet, completion: (tweet: FNBJSocialFeedTwitterTweet)->Void){
        
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
        
            let client = TWTRAPIClient(userID: userID)
            
            let url = "https://api.twitter.com/1.1/statuses/retweet/\(tweet.id).json"
            let params = ["id": tweet.id]
            var clientError: NSError?
            
            let request = client.URLRequestWithMethod("POST", URL: url, parameters: params, error: &clientError)
            
            client.sendTwitterRequest(request) { (res, data, err) in
                if let e = err {
                    print(e)
                }else if let data = data{
                
                    do {
                        
                        let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
 
                       let tweet = FNBJSocialFeedTwitterTweet(dictionary: json as! NSDictionary)
                        completion(tweet: tweet)
                        
                    } catch let jsonError as NSError {
                        print("json error: \(jsonError.localizedDescription)")
                    }
                }
            }

        }else{
        
            print("error")
        }
    }
    
    func reply(tweet: FNBJSocialFeedTwitterTweet, inReplyTo : FNBJSocialFeedTwitterTweet){
    
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
            
            let client = TWTRAPIClient(userID: userID)
            
            let url = "https://api.twitter.com/1.1/statuses/update.json"
            
            let params = ["status": tweet.text, "in_reply_to_status_id": inReplyTo.id]
            var clientError: NSError?
            
            let request = client.URLRequestWithMethod("POST", URL: url, parameters: params, error: &clientError)
            
            client.sendTwitterRequest(request) { (res, data, err) in
                if let e = err {
                    print(e)
                }else if let data = data{
                    
                }
            }
            
        }else{
            
            print("error")
        }
    }

    func getPublicPageSocialFeed(hashTag: String, completion: (tweets: [FNBJSocialFeedTwitterTweet], paging: String) -> Void){
    
        
        let statusesShowEndpoint = "https://api.twitter.com/1.1/search/tweets.json"
        let params = ["q": hashTag, "src": "typd"]
        var clientError : NSError?
        
        let request = client.URLRequestWithMethod("GET", URL: statusesShowEndpoint, parameters: params, error: &clientError)
    
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(connectionError)")
            }
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                let statuses = json.objectForKey("statuses") as? NSArray
                
                var tweets:[FNBJSocialFeedTwitterTweet] = []
                
                for status in statuses!{
                
                    let tweet = FNBJSocialFeedTwitterTweet(dictionary: (status as? NSDictionary)!)
                    tweets.append(tweet)
                }
                
                let metaData = json.objectForKey("search_metadata") as? NSDictionary
                
                var paging = ""
                
                if let next = metaData?.objectForKey("next_results") as? String{
                    paging = next
                }
            
                print("Paging: \(paging)")
                completion(tweets: tweets,paging: paging)
                
            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
            }
        }
        
    }
    
    func getPublicPageSocialFeed(withPagin paging: String, completion: (tweets: [FNBJSocialFeedTwitterTweet], paging: String) -> Void){
    
        //TODO: Twitter Paging
        let client = TWTRAPIClient()
        let url = NSURL(string: "https://api.twitter.com/1.1/search/tweets.json\(paging)")
        
        let a = NSURLRequest(URL: url!)
        
        client.sendTwitterRequest(a) { (response, data, connectionError) in
           
            if connectionError != nil {
                print("Error: \(connectionError)")
            }
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                let statuses = json.objectForKey("statuses") as? NSArray
                
                var tweets:[FNBJSocialFeedTwitterTweet] = []
                
                for status in statuses!{
                    
                    let tweet = FNBJSocialFeedTwitterTweet(dictionary: (status as? NSDictionary)!)
                    tweets.append(tweet)
                }
                
                let metaData = json.objectForKey("search_metadata") as? NSDictionary
                
                var paging = ""
                
                if let next = metaData?.objectForKey("next_results") as? String{
                    paging = next
                }
                
                print("Paging: \(paging)")
                completion(tweets: tweets,paging: paging)
                
            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
            }
        }
    }
    
    func checkForNewTweets(oldTweets: [FNBJSocialFeedTwitterTweet], completion: (hasNewTweets: Bool) -> Void){
    
        self.getPublicPageSocialFeed(self.hashtag) { (tweets, paging) in
            guard var new = tweets as? [FNBJSocialFeedTwitterTweet],
                var old = oldTweets as? [FNBJSocialFeedTwitterTweet] else{
            
                    completion(hasNewTweets: false)
                    return
            }
            
            new.sortInPlace({$0.date.isGreaterThanDate($1.date)})
            old.sortInPlace({$0.date.isGreaterThanDate($1.date)})
            
            if new[0].date.isGreaterThanDate(old[0].date){
                completion(hasNewTweets: true)
                return
            }
        }
        
        completion(hasNewTweets: false)
    }
}