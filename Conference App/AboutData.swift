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
    
    // Values to be Displayed on About Page
    var content = ""
    var logo = ""
    
    init() {
        // Get the JSON File
        let urlString = "http://djmobilesoftware.com/jsondata.json"
        let url = NSURL(string: urlString)
        
        // Start a NSURLSession to Download JSON
        if let url = url {
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                if let error =  error {
                    print("error: \(error.localizedDescription): \(error.userInfo)")
                }
                else if let data = data {
                    if let str = NSString(data: data, encoding: NSUTF8StringEncoding) {
                        //print("Received data:\n\(str)")
                        
                        do {
                            // Convert the JSON to Dictionary
                            let dictionary =  try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! NSDictionary
                            
                            // Parse About JSON Portion
                            let about = self.parseAbout(dictionary)
                            let logo = self.parseLogo(dictionary)
                            
                            // This is the final value with the text needed
                            self.content = about
                            self.logo = logo
                            
                        }
                        catch let error as NSError {
                            print(error)
                            
                            // This is used incase Internet Connection is not available
                            self.content = "ITEN Wired is a conference hosted by IT Gulf Coast and Florida West Economic Development Alliance. The annual summit provides networking and learning opportunities for executives, entrepreneurs, technology professionals and academia to foster local economic development efforts surrounding innovation, technology and entrepreneurship."
                        }
                        
                    }
                    else {
                        print("AboutData.swift: Unable to Convert Data to Text - JL")
                    }
                }
            })
            task.resume()
            
        }
        
    }
    init(c: String) {
        self.content = c
    }
    
    // Receives a NSDictionary that contains the JSON and converts 'conference_description' to String
    func parseAbout(dictionary:NSDictionary)->String {
        var about: String = ""
        if let aboutInformation = dictionary.objectForKey("conference_description") {
            about = aboutInformation as! String
        }
        return about
    }
    
    // Retrieve Logo URL from Dictionary
    func parseLogo(dictionary:NSDictionary)->String {
        var logo: String = ""
        if let logoInfo = dictionary.objectForKey("header_image_path") {
            logo = logoInfo as! String
        }
        return logo
    }
    
    // Used this for testing, shows the content variable
    func showContent()->String {
        return self.content
    }
    

}