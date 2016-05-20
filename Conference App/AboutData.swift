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
        
        let about = About(description: "",image: "")
        
        let data = appData.getDataFromFile()
        
        if let description = data["conference_description"] as? String{
            about.setDescription(description)
        }
        
        if let image = data["header_image_path"] as? String {
            about.setImage(image)
        }
        
        return about
    }
}