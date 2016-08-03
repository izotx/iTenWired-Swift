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

//  FNBJSocialFeedFacebookPost.swift
//  FNBJSocialFeed
//
//  Created by Felipe on 5/27/16.
//  Copyright © 2016 Academic Technology Center. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import FBSDKCoreKit

enum FNBJSocialFeedFacebookPostEnum : String{
    case message
    case name
    case from
    case object_id
    case picture
    case link
    case type
    case created_time
    case id
}

class FNBJSocialFeedFacebookPost{
    
    /// Facebook post message
    var message = ""
    
    /// The name of the link.
    var name = ""
    
    /// The Name of who posted
    var fromName = ""
    
    /// The ID of any uploaded photo or video attached to the post.
    var object_id = ""
    
    /// The picture scraped from any link included with the post.
    var picture = ""
    
    /// The link attached to this post.
    var link = ""
    
    /// A string indicating the object type of this post.
    var type = ""
    
    /// The time the post was initially published. For a post about a life event, this will be the date and time of the life event
    var created_time: NSDate!
    
    /// Facebook User 
    var user: FNBJSocialFeedFacebookUser = FNBJSocialFeedFacebookUser()
    
    /// UserID
    var userID = ""
    
    init(dictionary : NSDictionary){
    
        if let message = dictionary.objectForKey(FNBJSocialFeedFacebookPostEnum.message.rawValue) as? String{
            self.message = message
        }
        
        if let name = dictionary.objectForKey(FNBJSocialFeedFacebookPostEnum.name.rawValue) as? String{
            self.name = name
        }
        
        if let from = dictionary.objectForKey(FNBJSocialFeedFacebookPostEnum.from.rawValue
            ) as? NSDictionary {
            
            if let fromName = from.objectForKey(FNBJSocialFeedFacebookPostEnum.name.rawValue) as? String{
                self.fromName = fromName
            }
            
            if let id = from.objectForKey(FNBJSocialFeedFacebookPostEnum.id.rawValue) as? String{
                self.userID = id
            }
        }
        
        if let object_id = dictionary.objectForKey(FNBJSocialFeedFacebookPostEnum.object_id.rawValue) as? String{
            self.object_id = object_id
        }
        
        if let picture = dictionary.objectForKey(FNBJSocialFeedFacebookPostEnum.picture.rawValue) as? String {
            self.picture = picture
        }
        
        if let link = dictionary.objectForKey(FNBJSocialFeedFacebookPostEnum.link.rawValue) as? String{
            self.link = link
        }
        
        if let type = dictionary.objectForKey(FNBJSocialFeedFacebookPostEnum.type.rawValue) as? String {
            self.type = type 
        }
        
        if let dateString = dictionary.objectForKey(FNBJSocialFeedFacebookPostEnum.created_time.rawValue) as? String {
            
            let string = dateString.stringByReplacingOccurrencesOfString("T", withString: " ")
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH-mm-ssZZZ"
            
            self.created_time = dateFormatter.dateFromString(string)
        }
        
    }
}
