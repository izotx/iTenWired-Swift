//
//  Speaker.swift
//  Conference App
//
//  Created by Felipe Brito on 5/10/16.
//  felipenevesbrito@gmail.com - github.com/felipenbrito
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation


class Speaker : AttendeeProtocol {

    var id:Int = 0
    var name = ""
    var jobTitle = ""
    var bio = ""
    var company = ""
    var website = ""
    var linkedin = ""
    var email = ""
    var sessions:[String] = []
    
    
    init(dictionary: NSDictionary){
    
        if let id = dictionary.objectForKey(SpeakerEnum.id.rawValue) as? Int {
            self.id = id
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