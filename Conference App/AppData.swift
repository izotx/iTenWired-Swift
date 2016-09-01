//    Copyright (c) 2016, Izotx
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
//    * Neither the name of Izotx nor the names of its contributors may be used to
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
//
//  AppDataRequesting.swift
//  Conference App
//
//  Created by George Gruse on 4/15/16.


import Foundation

enum NetworkNotifications:String{
    case DataLoaded
}

class AppData{
   
    let defaults = NSUserDefaults.standardUserDefaults()
    //var URL: NSURL =  NSURL(string: "https://raw.githubusercontent.com/izotx/iTenWired-Swift/master/data.json")!
    //var URL: NSURL =  NSURL(string: "http://izotx.com/itenwired/")!
   
    var URL =  NSURL(string: "http://localhost:81/itenwired/")!
    
    
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
    
    func getDataFromFile()-> NSDictionary?{
        var dictionary:NSDictionary = NSDictionary()
        
        if let data = self.defaults.dataForKey("appData"){
            
            do {
                dictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! NSDictionary
                return dictionary
            } catch{
            }
        }
        return nil 
    }
    
    func getDataFromFile(completion: (dictionary:NSDictionary) -> Void){
        
        var dictionary:NSDictionary = NSDictionary()
        
        if let data = self.defaults.dataForKey("appData"){
            
            do {
                dictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! NSDictionary
                
                completion(dictionary: dictionary)
            } catch{
            }
        }
    
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
                    
                    
                }else{
                    print(error)
                }
                locked = false
            }
        }
        
        task.resume()
        
        while(locked){ // Runs untill the response is received
            
        }

        return returnData
    }
    
}
