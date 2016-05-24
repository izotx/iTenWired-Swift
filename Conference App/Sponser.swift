/**
 
Copyright (c) 2016, UWF 
All rights reserved. 

Redistribution and use in source and binary forms, with or without 
modification, are permitted provided that the following conditions are met: 

 * Redistributions of source code must retain the above copyright notice, 
   this list of conditions and the following disclaimer. 
 * Redistributions in binary form must reproduce the above copyright 
   notice, this list of conditions and the following disclaimer in the 
   documentation and/or other materials provided with the distribution. 
 * Neither the name of UWF nor the names of its contributors may be used to 
   endorse or promote products derived from this software without specific 
   prior written permission. 

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
POSSIBILITY OF SUCH DAMAGE.
 
*/
//  Sponser.swift
//  Conference App
//
//  Created by Felipe Brito {felipenevesbrito@gmail.com} on 5/9/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation


class Sponser: AttendeeProtocol{

    var id:Int = 0
    var name:String = ""
    var level:String = ""
    var description:String = ""
    var logo:String = ""
    var website:String = ""
    
    
    init(dictionary: NSDictionary){
        
        if let id =   dictionary.objectForKey(SponserEnum.id.rawValue) as? Int {
            self.id = id
        }
        
        if let name = dictionary.objectForKey(SponserEnum.name.rawValue) as? String{
            self.name = name
        }
        
        if let level = dictionary.objectForKey(SponserEnum.level.rawValue) as? String{
            self.level = level
        }
        
        if let description = dictionary.objectForKey(SponserEnum.description.rawValue) as? String{
            self.description = description
        }
        
        if let logo = dictionary.objectForKey(SponserEnum.logo.rawValue) as? String{
            self.logo = logo
        }
        
        if let website = dictionary.objectForKey(SponserEnum.logo.rawValue) as? String{
            self.website = website
        }
    }
}


enum SponserEnum:String{
    case id
    case name
    case level
    case description
    case logo
    case website
}
