//
//  appDataRequester.swift
//  Conference App
//
//  Created by George Gruse on 4/15/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation
class appDataRequester {
    var path: NSString
    var mainFile: String
    
    //Make sure that this url is the main json request
    var dataPath: NSURL =  NSURL(string: "http://djmobilesoftware.com/jsondata.json")!
    
    init()
    {
        let dir:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first!
        mainFile = "jsonData.dat"
        path = dir.stringByAppendingPathComponent(mainFile);
    }
    func initData()
    {
        let data:NSData = getDataFromURL(dataPath)!
        data.writeToFile(path.stringByAppendingPathExtension(mainFile)!, atomically: true)
    }
    func getDataFromFile()-> NSDictionary
    {
        return NSDictionary.init(contentsOfFile:(path.stringByAppendingPathExtension(mainFile)!))!
    }
    func getDataFromURL(requestURL: NSURL) -> NSData?{
        
        var locked = true       // Flag to make sure the
        var returnData:NSData?
        
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                
                let statusCode = httpResponse.statusCode
                
                if (statusCode == 200) {
                    returnData = data!
                }else{
                    print("Error while retriving data!")
                }
                locked = false
                
            }
        }
        
        
        task.resume()
        
        while(locked){ // Runs untill the response is received
            
        }
        
        return returnData
    }
    //Credit to http://stackoverflow.com/questions/24097826/read-and-write-data-from-text-file by user Adam on the stack
    //overflow site
}
