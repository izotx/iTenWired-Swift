//
//  appendToMyIten.swift
//  Conference App
//
//  Created by George Gruse on 4/15/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation
class appendToMyIten {
    var path: NSString
    var mainFile: String
    var file:String = ""
    var newLine:NSCharacterSet = NSCharacterSet.newlineCharacterSet()
    var agenda: AgendaController
    var events:[Event] = [Event]()
    init()
    {
        let dir:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first!
        mainFile = "data.dat"
        path = dir.stringByAppendingPathComponent(mainFile);
        agenda = AgendaController()
        
        do
        {
            file = try String(contentsOfFile: path as String)
            if(!file.isEmpty)
            {
                events = self.myItenEvents()
            }
        }
        catch{}
       
    }
    
    //Credit to http://stackoverflow.com/questions/24097826/read-and-write-data-from-text-file by user Adam on the stack
    //overflow site
    func reloadData()
    {
        do
        {
            file = try String(contentsOfFile: path as String)
            events = self.myItenEvents()
        }
        catch{}
    }
    func appendAgenda(event :Event)
    {
        reloadData()
        var doesContainEvent:Bool = false
        for tempEvent in self.myItenEvents()
        {
            if(!doesContainEvent)
            {
               doesContainEvent = tempEvent.id == event.id
            }
        }
        if(!doesContainEvent)
        {
            let data:NSString = file + "|id|\(event.id)|Date|\(event.date)\n"
            do{
            
                try data.writeToFile(path as String, atomically: false, encoding: NSUTF8StringEncoding)
            }
            catch {}
            reloadData()
        }
        reloadData()
    }
    func removeData(id: Int)
    {
        reloadData()
        do
        {
            var data = file.utf16.split{newLine.characterIsMember($0)}.flatMap(String.init)
            if(data.count>0)
            {
                for index in 0 ... (data.count-1)
                {
                    if(data.count>index)
                    {
                        if(data[index].componentsSeparatedByString("|Date|")[0].containsString("\(id)"))
                        {
                            data.removeAtIndex(index)
                        }
                    }
                }
            }
            let finalData = data.sort().joinWithSeparator("\n")
            
            
            try finalData.writeToFile(path as String, atomically: false, encoding: NSUTF8StringEncoding)
        }
        catch{}
        reloadData()
        
    }
    func getFileInIten(id: Int)->Bool
    {
        var inFile = true
        reloadData()
        var data = file.utf16.split{newLine.characterIsMember($0)}.flatMap(String.init)
        if(data.count>0)
        {
            for index in 0 ... (data.count-1)
            {
                if(data.count>index)
                {
                    if(data[index].componentsSeparatedByString("|Date|")[0].containsString("\(id)"))
                    {
                        inFile = false
                    }
                }
            }
        }
        reloadData()
        return inFile
    }
    
    func getData() -> [Int] {
        
        var data = file.utf16.split{newLine.characterIsMember($0)}.flatMap(String.init)
        var dataParsed: [Int] = [Int]()
        if(data.count>0)
        {
            for index in 0 ... (data.count-1)
            {
                var tempData = data[index].componentsSeparatedByString("|Date|")[0]
                tempData = tempData.substringFromIndex(tempData.startIndex.advancedBy(4))
                dataParsed.append((Int)(tempData)!)
            }
        }
        return dataParsed;
    }
    func myItenEvents() -> [Event]
    {
        
        let listId:[Int] = getData()
        var events:[Event] = [Event]()
        if(listId.count>0){
            for i in listId
            {
                events.append(agenda.getById(i))
            }
        }
        return events
    }
    
    
    
}
