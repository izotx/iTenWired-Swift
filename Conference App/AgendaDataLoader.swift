//
//  AgendaDataLoader.swift
//  Agenda1
//
//  Created by Felipe Neves Brito on 4/5/16.
//  Copyright © 2016 Felipe Neves Brito. All rights reserved.
//

import Foundation

class AgendaDataLoader{

    private var agenda:Agenda = Agenda()
    
    
    init(){
       
    }
    
    internal func loadAgenda(data:NSData){
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(data, options:.AllowFragments)
            
            if let eventsJSON = json["events"] as? [NSDictionary] {
                
                
                for eventJson in eventsJSON {
                    
                    let event =  Event(dictionary: eventJson)
                    self.agenda.addEvent(event)
                }
            }
            
        } catch {
            print("Error with Json: \(error)")
        }
        
    }
    
    
    func loadAgenda(){
        let appData = AppData()
        
        let data = appData.getDataFromFile()
       
        if let eventsData = data["events"] as? [NSDictionary]{
            for eventData in eventsData{
                let event =  Event(dictionary: eventData)
                self.agenda.addEvent(event)
            }
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

    func getAgenda() -> Agenda {
        
       // let requestURL: NSURL = NSURL(string: "http://djmobilesoftware.com/jsondata.json")! // URL for the JSON file
       // let data:NSData = self.getDataFromURL(requestURL)!  //loads the JSON data from the URL
        self.loadAgenda()   // Parses the data into agenda
        return self.agenda
        
    }
}