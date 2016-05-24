//
//  AboutData.swift
//  Conference App
//
//  Created by Julian L on 4/12/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

// Used to Parse About Page and Retrieve Logo - UIImage
class AboutData {
    
   let appData = AppData()
    
    func getAbout() -> About {
        
        let data = appData.getDataFromFile()
        
        guard let description = data["conference_description"] as? String,
            let imageURL = data["header_image_path"] as? String else{
                
                return About(description: "", imageURL: "")
        }
        
        let about = About(description: description, imageURL: imageURL)
        
        return about
    }
}