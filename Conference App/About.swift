//
//  About.swift
//  Conference App
//
//  Created by Felipe on 5/17/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit

class About {

    var description = ""
    var image = ""
    
    
    init(description: String, image: String){
        self.description = description
        self.image = image
    }
    
    func setDescription(description:String){
        self.description = description
    }
    
    func setImage(URLString : String){
        self.image =  URLString
    }
}

