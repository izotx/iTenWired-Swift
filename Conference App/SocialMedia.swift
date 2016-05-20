//
//  SocialMedia.swift
//  Conference App
//
//  Created by Felipe on 5/17/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

enum SocialMediaEnum : String{
    case label
    case URL
}

class SocialMedia{

    var label = ""
    var URL = ""
    
    init(dictionary : NSDictionary){
    
        if let label = dictionary.objectForKey(SocialMediaEnum.label.rawValue) as? String {
            self.label = label
        }
        
        if let URL = dictionary.objectForKey(SocialMediaEnum.URL.rawValue) as? String {
            self.URL = URL
        }
    }
}