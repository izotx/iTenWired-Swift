//
//  AppDataRequesting.swift
//  Conference App
//
//  Created by George Gruse on 4/15/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

enum NetworkNotifications:String{
    case DataLoaded
}

class AppData{
   
    let defaults = NSUserDefaults.standardUserDefaults()
    var URL: NSURL =  NSURL(string: "http://djmobilesoftware.com/itenwired/jsondata.json")!

    
    init()
    {
    
    }

    func getAllNotifications() -> [Notification] {
        let arr = [Notification]()
        var notificationsArray = NotificationList(notifications: arr)
        
        NSKeyedUnarchiver.setClass(NotificationList.self, forClassName: "NotificationList")
        if let data = self.defaults.objectForKey("Notifications") as? NSData{
            if let notifications = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? NotificationList {
                notificationsArray = notifications
            }
        }
        return notificationsArray.getArray().sort({$0.date.compare($1.date) == NSComparisonResult.OrderedDescending})
    }
    
    func getDataFromFile()-> NSDictionary{
        var dictionary:NSDictionary = NSDictionary()
        
        if let data = self.defaults.dataForKey("appData"){
            
            do {
                dictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! NSDictionary
                return dictionary
            } catch{
            }
        }
        return dictionary
    }
    
    func saveData(){
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        sessionConfiguration.requestCachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: self.URL)
        let session = NSURLSession(configuration: sessionConfiguration)
        
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                
                let statusCode = httpResponse.statusCode
                
                if (statusCode == 200) {
                    self.defaults.setObject(data, forKey: "appData")
                    self.defaults.synchronize()
                }else{
                    print("Error while retriving data!")
                }
            }
        }
        task.resume()
    }
    
    func getDataFromURL(requestURL: NSURL) -> NSData?{
        
        var locked = true       // Flag to make sure the
        var returnData:NSData?
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        sessionConfiguration.requestCachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData

        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession(configuration: sessionConfiguration)
        
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                
                let statusCode = httpResponse.statusCode
                
                if (statusCode == 200) {
                    returnData = data!
                    //print(returnData)
                    
                    
                }else{
                    print("Error while retriving data!")
                }
                locked = false
            }
        }
        
        
        task.resume()
        
        while(locked){ // Runs untill the response is received
            
        }
        print("3")

        return returnData
    }
    
}
