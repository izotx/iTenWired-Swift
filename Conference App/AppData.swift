//
//  AppDataRequesting.swift
//  Conference App
//
//  Created by George Gruse on 4/15/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

class AppData {
    var path: String
    var mainFile: String
    var agenda: Agenda
    var status: Bool = true
    //Make sure that this url is the main json request
    var dataPath: NSURL =  NSURL(string: "http://djmobilesoftware.com/jsondata.json")!
    var otherPath: String
    
    init()
    {
        let dir:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first!
        mainFile = "jsonData.json"
        agenda = Agenda()
        otherPath = dir.stringByAppendingPathComponent("data.dat")
        path = dir.stringByAppendingPathComponent(mainFile);
        
    }
    func initData()
    {
        let data:NSData = getDataFromURL(dataPath)!
        data.writeToFile(path as String, atomically: false)
        checkForPurgeFiles()
        if(!status)
        {
            print("Out of date files")
        }
    }
    func getDataBear()->NSDictionary
    {
        var resultDictionary: NSData?
        var dictionary: NSDictionary?
        do {
            resultDictionary = try NSData(contentsOfFile:path)
            if((resultDictionary) != nil)
            {
                dictionary =  try NSJSONSerialization.JSONObjectWithData(resultDictionary!, options: .MutableContainers) as! NSDictionary
            }
            else
            {
                initData()
                do {
                    resultDictionary = try NSData(contentsOfFile:path)
                    dictionary =  try NSJSONSerialization.JSONObjectWithData(resultDictionary!, options: .MutableContainers) as! NSDictionary
                }
                catch {
                    
                }
            }
        }
        catch {
            
        }
        
        return dictionary!
        
    }
    func getDataFromFile()-> NSDictionary
    {
        checkForPurgeFiles()
        return getDataBear()
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
    
    //
    func checkForPurgeFiles()
    {
        var pastDate: Bool = false
        var data: NSDictionary = getDataBear()
        
        do{
            
            
            if let eventsJSON = data["events"] as? [NSDictionary] {
                
                
                for eventJson in eventsJSON {
                    
                    let event =  Event(dictionary: eventJson)
                    agenda.addEvent(event)
                }
            }
            
        } catch {
            print("Error with file: \(error)")
            
        }
        let allUnits = NSCalendarUnit(rawValue: UInt.max)
        var date = NSDate()
        let components = NSCalendar.currentCalendar().components(allUnits, fromDate: date)
        
        for event in agenda.events
        {
            var dateFromString:[Int] = [Int]()
            var dateString = (event.date).characters.split{$0 == "/"}.map(String.init)
            dateFromString.append(Int(dateString[0])!)
            dateFromString.append(Int(dateString[1])!)
            dateFromString.append(Int(dateString[2])!)
            
            
            if(status)
            {
                var m = components.month
                var y = components.year
               //status =  !(y > dateFromString[2] || (m > dateFromString[0] &&   y == dateFromString[2]))
            }
            
        }
        if(!status)
        {
            let str:NSData = NSData()
            str.writeToFile(path as String, atomically: false)
            str.writeToFile(otherPath as String, atomically: false)
        }
    }
    func clearItin()
    {
        let str:NSData = NSData()
        str.writeToFile(otherPath as String, atomically: false)
    }
    
    //Credit to http://stackoverflow.com/questions/24097826/read-and-write-data-from-text-file by user Adam on the stack
    //overflow site
}
