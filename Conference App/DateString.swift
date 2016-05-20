//
//  DateCalculator.swift
//  Conference App
//
//  Created by Felipe on 5/13/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

class DateString{

    var date = ""
    
    init(date:String){
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss"
        let formatedDate = dateFormatter.dateFromString(date)
        
        dateFormatter = NSDateFormatter()
        
        self.date = dateFormatter.stringFromDate(formatedDate!)
        
        print(self.date)
    }

    func getYear() -> Int{
        return Int(date.componentsSeparatedByString(" ")[0].componentsSeparatedByString("-")[0])!
    }
    
    func getMonth() -> Int{
        return Int(date.componentsSeparatedByString(" ")[0].componentsSeparatedByString("-")[1])!
    }
    
    func getDay() -> Int{
       return Int(date.componentsSeparatedByString(" ")[0].componentsSeparatedByString("-")[2])!
    }
    
    func getDateString() -> String{
       return "\(getMonth())/\(getDay())/\(getYear())"
    }
    
    func getHour() -> Int{
        return Int(date.componentsSeparatedByString(" ")[1].componentsSeparatedByString(":")[0])!
    }
    
    // returns a string with the time diference bettween the dates
    // if diference is more than a 7 days, the actual date wil be return
    
    func compareToCurrentDate() -> String {
    
        let now = NSDate()
        
       /* if now. == self.getYear(){
            if other.getMonth() == self.getMonth() {
                
                let daysDifference = other.getDay() - self.getDay()
                if  daysDifference == 0 {
                    
                }else {
                    return "\(daysDifference)d"
                }
            }
        }*/
        
        return self.getDateString()
    }
}

enum MonthEnum : Int{
    case Jan
    case Feb
    case May
    case Apr
    case Jun
    case Jul
    case Aug
    case Sep
    case Oct
    case Nov
    case Dec
}