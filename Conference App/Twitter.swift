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

//  Twitter.swift
//  Conference App
//
//  Created by Felipe on 5/12/16.



import Foundation

enum TwitterEnum:String{
    case text
    case user
    case created_at
}

class Twitter{
    
    /// Tweet Message
    var text = ""
    
    /// Tweet user's information
    var user:TwitterUser!
    
    /// Tweet creation date
    var createdAt = ""
    
    
    init(dictionary: NSDictionary){
        
        if let text = dictionary.objectForKey(TwitterEnum.text.rawValue) as? String{
            self.text = text
        }
        
        if let user = dictionary.objectForKey(TwitterEnum.user.rawValue) as? NSDictionary{
            
            self.user = TwitterUser(dictionary: user)
        }
        
        if let createdAt = dictionary.objectForKey(TwitterEnum.created_at.rawValue) as? String {
            self.createdAt = createdAt
        }
    }
}