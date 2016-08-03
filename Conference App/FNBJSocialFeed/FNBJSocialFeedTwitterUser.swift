//
//  FNBJSocialFeedTwitterUser.swift
//  FNBJSocialFeed
//
//  Created by Felipe on 5/31/16.
//  Copyright © 2016 Academic Technology Center. All rights reserved.
//

import Foundation

enum FNBJSocialFeedTwitterUserEnum : String{
    case name
    case profile_image_url
    case screen_name
}

class FNBJSocialFeedTwitterUser{

    /// User name
    var name = ""
    
    /// Profile image's URL
    var profileImage = ""
    
    /// User Screen Name
    var screenName = ""
    
    init(dictionary: NSDictionary){
    
        if let name = dictionary.objectForKey(FNBJSocialFeedTwitterUserEnum.name.rawValue) as? String {
            self.name = name 
        }
        
        if let image = dictionary.objectForKey(FNBJSocialFeedTwitterUserEnum.profile_image_url.rawValue) as? String{
            self.profileImage = image 
        }
        
        if let screenName = dictionary.objectForKey(FNBJSocialFeedTwitterUserEnum.screen_name.rawValue) as? String {
            self.screenName = screenName
        }
    }
}
