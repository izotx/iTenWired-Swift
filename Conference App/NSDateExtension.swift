//
//  NSDateEctension.swift
//  FNBJSocialFeed
//
//  Created by Felipe on 6/6/16.
//  Copyright © 2016 Academic Technology Center. All rights reserved.
//

import Foundation


extension NSDate {
    
    func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
        var isGreater = false
        
        if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending {
            isGreater = true
        }
        
        return isGreater
    }
    
    func isLessThanDate(dateToCompare: NSDate) -> Bool {
        var isLess = false
        
        if self.compare(dateToCompare) == NSComparisonResult.OrderedAscending {
            isLess = true
        }
        
        return isLess
    }
    
    func equalToDate(dateToCompare: NSDate) -> Bool {
        var isEqualTo = false
        
        if self.compare(dateToCompare) == NSComparisonResult.OrderedSame {
            isEqualTo = true
        }
        
        return isEqualTo
    }
    
    func addDays(daysToAdd: Int) -> NSDate {
        let secondsInDays: NSTimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: NSDate = self.dateByAddingTimeInterval(secondsInDays)
        
        return dateWithDaysAdded
    }
    
    func addHours(hoursToAdd: Int) -> NSDate {
        let secondsInHours: NSTimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: NSDate = self.dateByAddingTimeInterval(secondsInHours)
        
        return dateWithHoursAdded
    }
    
    func stringDateSinceNow() -> String{
        
        let time = self.timeIntervalSinceNow * -1
        
        var intTime:Int = Int(time)
        
        if intTime < 60 {
            return "\(intTime)s"
        }
        
        intTime = intTime / 60
        
        if intTime < 60{
            return "\(intTime)m"
        }
        
        intTime = intTime / 60
        
        if intTime < 24 {
            return "\(intTime)h"
        }
        
        intTime = intTime / 24
        
        if intTime < 7 {
            return "\(intTime)d"
        }
        
        intTime = intTime / 7
        
        if intTime < 5 {
            return "\(intTime)w"
        }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        
        return dateFormatter.stringFromDate(self)
    }
}
