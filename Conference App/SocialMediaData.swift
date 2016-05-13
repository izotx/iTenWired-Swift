//
//  SocialMediaData.swift
//  Conference App
//
//  Created by Christopher Rijos on 4/21/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

class SocialMediaData {
    
    //backup url
    let url = "http://www.facebook.com/itenwired"
    var content: String = ""
    
    init() {
        
        //FIXME: Remove networking code
        
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
                    if NSString(data: data, encoding: NSUTF8StringEncoding) != nil {
                        //print("Received data:\n\(str)")
                        
                        do {
                            // Convert the JSON to Dictionary
                            let dictionary =  try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! NSDictionary
                            
//                            if let links = dictionary.objectForKey("jsondata"){
//                                let linkArray = links["label"] as! NSArray
//                                for items in linkArray{
//                                    let facebookURL = items["facebook"]
//                                    self.content = (facebookURL as? String)!
//                                }
//                            }
                            
                            if let sociallinks = dictionary.objectForKey("links") as? NSArray {
                                for link in sociallinks {
                                    if let newLink = link["URL"] as? String, let newLabel = link["label"] as? String {
                                   
                                        if newLabel == "twitter" {
                                            self.content = newLink
                                        }
                                    }
                                    
                                }
                            }
                            
                            print(self.content)
                        }
                        catch let error as NSError {
                            print(error)
                            
                        }
                        
                    }
                    else {
                       
                    }
                }
            })
            task.resume()    } }
    
    func getURLContent() -> String{
        return self.content;
    }
}