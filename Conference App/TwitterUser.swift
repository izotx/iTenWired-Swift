//
//  TwitterUser.swift
//  Conference App
//
//  Created by Felipe on 5/12/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

class TwitterUser{

    var name = ""
    var screenName = ""
    var profileImage = ""
    
    init(dictionary:NSDictionary){
        if let name = dictionary.objectForKey(TwitterUserEnum.name.rawValue) as? String{
            self.name = name
        }
        if let profileImage = dictionary.objectForKey(TwitterUserEnum.profile_image_url.rawValue) as? String {
            self.profileImage = profileImage
        }
        if let screenName = dictionary.objectForKey(TwitterUserEnum.screen_name.rawValue) as? String {
            self.screenName = screenName
        }
    }
}

enum TwitterUserEnum : String{
    case name
    case profile_image_url
    case screen_name
}