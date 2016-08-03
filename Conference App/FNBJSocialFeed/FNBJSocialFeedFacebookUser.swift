//
//  FNBJSocialFeedFacebookUser.swift
//  FNBJSocialFeed
//
//  Created by Felipe on 6/1/16.
//  Copyright © 2016 Academic Technology Center. All rights reserved.
//

import Foundation

enum FNBJSocialFeedFacebookuserEnum : String{
    case name
    case url
    case picture
    case data
}

class FNBJSocialFeedFacebookUser{

    var profilePicture = ""
    
    
    
//    init(dictionary: NSDictionary){
//    
//        if let name = dictionary.objectForKey(FNBJSocialFeedFacebookuserEnum.name.rawValue) as? String{
//            self.name = name
//        }
//        
//        if let picture = dictionary.objectForKey(FNBJSocialFeedFacebookuserEnum.picture.rawValue) as? NSDictionary{
//        
//            if let data = picture.objectForKey(FNBJSocialFeedFacebookuserEnum.data.rawValue) as? NSDictionary{
//            
//                if let url = data.objectForKey(FNBJSocialFeedFacebookuserEnum.url.rawValue) as? String{
//                    print (url)
//                    
//                    self.profilePicture = url 
//                }
//            }
//        
//        }
//    
//    }

}