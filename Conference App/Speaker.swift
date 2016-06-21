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

//  Speaker.swift
//  Conference App
//  Created by Felipe Brito {felipenevesbrito@gmail.com} on 5/10/16.

import Foundation

/// Speaker's attributes
enum SpeakerEnum : String {
    case id
    case name
    case jobtitle
    case bio
    case company
    case website
    case linkedin
    case email
    case sessions
}

class Speaker : AttendeeProtocol {

    /// Speaker's unique id
    var id = 0
    
    var name = ""
    var jobTitle = ""
    var bio = ""
    var company = ""
    var website = ""
    var linkedin = ""
    var email = ""
    var sessions:[String] = []
    
    
    init(dictionary: NSDictionary){
    
        if let id = dictionary.objectForKey(SpeakerEnum.id.rawValue) as? String {
            self.id = Int(id)!
        }
        
        if let name = dictionary.objectForKey(SpeakerEnum.name.rawValue) as? String {
            self.name = name
        }
        
        if let jobTitle = dictionary.objectForKey(SpeakerEnum.jobtitle.rawValue) as? String {
            self.jobTitle = jobTitle
        }
        
        if let bio = dictionary.objectForKey(SpeakerEnum.bio.rawValue) as? String {
            self.bio = bio
        }
        
        if let company = dictionary.objectForKey(SpeakerEnum.company.rawValue) as? String {
            self.company = company
        }
        
        if let website = dictionary.objectForKey(SpeakerEnum.website.rawValue) as? String {
            self.website = website
        }
        
        if let linkedin = dictionary.objectForKey(SpeakerEnum.linkedin.rawValue) as? String {
            self.linkedin = linkedin
        }
        
        if let email = dictionary.objectForKey(SpeakerEnum.email.rawValue) as? String {
            self.email = email
        }
        
        if let sessions = dictionary.objectForKey(SpeakerEnum.sessions.rawValue) as? [String] {
            self.sessions = sessions
        }
    }
}