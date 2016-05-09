//
//  AttendeeData.swift
//  Conference App
//
//  Created by tuong on 4/13/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation


class AttendeeData{
    
    private var attendee:Attendee = Attendee()
    
    init(){
        
    }
    internal func loadSponsors(data:NSData){
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(data, options:.AllowFragments)
            
            if let eventsJSON = json["sponsors"] as? [NSDictionary] {
                
                
                for eventJson in eventsJSON {
                    
                    let event =  Event(dictionary: eventJson)
                    self.attendee.addEvent(event)
                }
            }
            
        } catch {
            print("Error with Json: \(error)")
        }
        
    }
    //json Exhibitor
    internal func loadExhibitor(data:NSData){
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(data, options:.AllowFragments)
            
            if let eventsJSON = json["exhibitors"] as? [NSDictionary] {
                
                
                for eventJson in eventsJSON {
     
                    let event =  Event(dictionary: eventJson)
                    self.attendee.addEvent(event)
                }
            }
            
        } catch {
            print("Error with Json: \(error)")
        }
        
    }
    internal func loadSpeakers(data:NSData){
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(data, options:.AllowFragments)
            
            if let eventsJSON = json["speakers"] as? [NSDictionary] {
                
                
                for eventJson in eventsJSON {
                    
                    let event =  Event(dictionary: eventJson)
                    self.attendee.addEvent(event)
                }
            }
            
        } catch {
            print("Error with Json: \(error)")
        }
        
    }
    

    internal func getDataFromURL(requestURL: NSURL) -> NSData?{
        
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
    
    func getAttendee() -> Attendee {
        let requestURL: NSURL = NSURL(string: "http://djmobilesoftware.com/jsondata.json")! // URL for the JSON file
        let data:NSData = self.getDataFromURL(requestURL)!  //loads the JSON data from the URL
        self.loadSponsors(data)
        self.loadExhibitor(data)
        self.loadSpeakers(data)
        return self.attendee
    }
}