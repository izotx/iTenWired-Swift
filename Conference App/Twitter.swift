//
//  Twitter.swift
//  Conference App
//
//  Created by Felipe on 5/12/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

class Twitter{

    var text = ""
    var user:TwitterUser!
    
    
    init(dictionary: NSDictionary){
        
        if let text = dictionary.objectForKey(TwitterEnum.text.rawValue) as? String{
            self.text = text
        }
        
        if let user = dictionary.objectForKey(TwitterEnum.user.rawValue) as? NSDictionary{
            
            self.user = TwitterUser(dictionary: user)
        }
    }
}


enum TwitterEnum:String{
    case text
    case user
}