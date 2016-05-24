//
//  About.swift
//  Conference App
//
//  Created by Felipe on 5/17/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit

/// Information about the ItenWired
class About {
    
    // The conference description
    var description:String
    
    // The url to the conference's logo
    var image:String
    
    
    /**
        Initializes the conference about information.
     
        - Parameters:
            - description: The conference description
            - imageURL: The web link to the conference's head logo
 
    */
    init(description: String, imageURL: String){
        self.description = description
        self.image = imageURL
    }
}

